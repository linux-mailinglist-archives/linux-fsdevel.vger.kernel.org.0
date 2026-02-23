Return-Path: <linux-fsdevel+bounces-77947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHNxKfZVnGkAEQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 14:28:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D750176D9E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 14:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 206A23128F7D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 13:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FC01DE4FB;
	Mon, 23 Feb 2026 13:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U2WgFX6S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2289618787A;
	Mon, 23 Feb 2026 13:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771852972; cv=none; b=FyFoGH281WZo9Rc5DGE4e8VWUkHKMBprxXnQiHJkX4V/3JwxJriCnVTymG3aVYsEDuIqg3M8ZhZtj7PBPhqnMVGEFi4bXYV46Mbiv5FwPFp+owKSVO7yw+7WAk/3Ib9826VCj6ROedr7miHVJlUwzd8T+jaNHahiJBwpPnPKfs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771852972; c=relaxed/simple;
	bh=Y9zQpBnOY3XsNhwdPyvpSO9SQI9w3QLDzOcy7Bn/HBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gYCu63pCE/sqvKod7jS0GEzznM6d7o3QDo8x2uABylM5CIPlnNVwGhhIkbWakoTHhJo1Jf0oXXhZWz/2rD+0cjshhppgukozRfupD5rqS3Ccqo6TYx2G4eyI6PO0rbozYPPCAjKje6KfBYInIjRXWbv8T2z5wSgHEGDATA52Sk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=U2WgFX6S; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=vqmLMmLSuW58/h9+4XMmo+oe3hP9517pKNkmn5AFtrA=; b=U2WgFX6SWjPjjjy6s6ybNWj5pw
	XetNd257kDWWKekfeKA5OTZv0bgfEvfYhqq712rM4kKPkkLQSVLR4x0zhgW8UKcORWoUPnFjI2oHj
	sRDDE+eCSumP2sggU+cApczzkdlS5GizF/ikpBeRJKcbWqjRjib835lpntumIC+1amcRsL6iC51lx
	1kXBG3KTxDS/TdcxDa0e662vTkGLRsa5s04gL00H6l7dBTr1LGAqxuYIyv+HFeBDiYs3i3konlJlP
	fBCO6Uwdu1hQS7IvHnm1wOy50pz9uLnONleGBFZldfIQfx1rthFhhrYRo1TP3i/UbAkYoQbK9MffN
	D4XRQlxg==;
Received: from [94.156.175.41] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuVth-00000000M3C-0GZh;
	Mon, 23 Feb 2026 13:22:50 +0000
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
Subject: [PATCH 11/16] iomap: allow file systems to hook into buffered read bio submission
Date: Mon, 23 Feb 2026 05:20:11 -0800
Message-ID: <20260223132021.292832-12-hch@lst.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-77947-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,samsung.com:email,lst.de:mid,lst.de:email,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1D750176D9E
X-Rspamd-Action: no action

File systems such as btrfs have additional operations with bios such as
verifying data checksums.  Allow file systems to hook into submission
of the bio to allow for this processing by replacing the direct
submit_bio call in iomap_read_alloc_bio with a call into ->submit_read
and exporting iomap_read_alloc_bio.  Also add a new field to
struct iomap_read_folio_ctx to track the file logic offset of the current
read context.

Based on a patch from Goldwyn Rodrigues <rgoldwyn@suse.com>.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Tested-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/iomap/bio.c        | 15 +++++++++------
 include/linux/iomap.h |  4 ++++
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/bio.c b/fs/iomap/bio.c
index 80bbd328bd3c..903cb9fe759e 100644
--- a/fs/iomap/bio.c
+++ b/fs/iomap/bio.c
@@ -32,10 +32,11 @@ static void iomap_read_alloc_bio(const struct iomap_iter *iter,
 	struct folio *folio = ctx->cur_folio;
 	gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
 	gfp_t orig_gfp = gfp;
-	struct bio *bio = ctx->read_ctx;
+	struct bio *bio;
 
-	if (bio)
-		submit_bio(bio);
+	/* Submit the existing range if there was one. */
+	if (ctx->read_ctx)
+		ctx->ops->submit_read(iter, ctx);
 
 	/* Same as readahead_gfp_mask: */
 	if (ctx->rac)
@@ -56,9 +57,10 @@ static void iomap_read_alloc_bio(const struct iomap_iter *iter,
 	bio_add_folio_nofail(bio, folio, plen,
 			offset_in_folio(folio, iter->pos));
 	ctx->read_ctx = bio;
+	ctx->read_ctx_file_offset = iter->pos;
 }
 
-static int iomap_bio_read_folio_range(const struct iomap_iter *iter,
+int iomap_bio_read_folio_range(const struct iomap_iter *iter,
 		struct iomap_read_folio_ctx *ctx, size_t plen)
 {
 	struct folio *folio = ctx->cur_folio;
@@ -70,10 +72,11 @@ static int iomap_bio_read_folio_range(const struct iomap_iter *iter,
 		iomap_read_alloc_bio(iter, ctx, plen);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(iomap_bio_read_folio_range);
 
 const struct iomap_read_ops iomap_bio_read_ops = {
-	.read_folio_range = iomap_bio_read_folio_range,
-	.submit_read = iomap_bio_submit_read,
+	.read_folio_range	= iomap_bio_read_folio_range,
+	.submit_read		= iomap_bio_submit_read,
 };
 EXPORT_SYMBOL_GPL(iomap_bio_read_ops);
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 6fbe121e2adf..b2b9e649a3b8 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -493,6 +493,7 @@ struct iomap_read_folio_ctx {
 	struct folio		*cur_folio;
 	struct readahead_control *rac;
 	void			*read_ctx;
+	loff_t			read_ctx_file_offset;
 };
 
 struct iomap_read_ops {
@@ -599,6 +600,9 @@ int iomap_swapfile_activate(struct swap_info_struct *sis,
 extern struct bio_set iomap_ioend_bioset;
 
 #ifdef CONFIG_BLOCK
+int iomap_bio_read_folio_range(const struct iomap_iter *iter,
+		struct iomap_read_folio_ctx *ctx, size_t plen);
+
 extern const struct iomap_read_ops iomap_bio_read_ops;
 
 static inline void iomap_bio_read_folio(struct folio *folio,
-- 
2.47.3


