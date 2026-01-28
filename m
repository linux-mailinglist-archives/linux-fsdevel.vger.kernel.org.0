Return-Path: <linux-fsdevel+bounces-75762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOpaO+A8emlB4wEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:44:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3806CA60D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DB317308156E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 16:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B201830FC05;
	Wed, 28 Jan 2026 16:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XDp39fPT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3FE30DED4;
	Wed, 28 Jan 2026 16:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616995; cv=none; b=lwv4bXKM/5ty9qLYlMtsSWrAugg6ES6S8oZfR5AQjo8CzW6D/ujQ38v0vmxBg4xrrQRMSXavpaRWZ+esKwxwaJZ/bGyuCT/Ap2gPjAM+VorjKWxC0zvXGgj31BJ51MLGQheubzUDhevy2fGnsfqSfOXyc7F5o6my3y1zai/9Xx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616995; c=relaxed/simple;
	bh=BVtsHw67v3uldRgYETaX+Q8lhhqfsHRHPoA4QyKhcLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BUHelps1zWbcVCh1x/3zFt2Mi976Q8WLgmqh9yRI73U57Qnm3kHjcAnx8hjJQqxtv8SyKVZvkCWeFdj4QuHdPNRZ3wk7sa8/S4zOuYTW04Fi09RgIdauSvCl9v/oXKyzzHXA3yFI/5++FBmywDYmIMBRn1dNBc/OflSTFZpwm2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XDp39fPT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=8DiMxhagqjaMgX9MPxAQhAAMe3lVCN73dG8Bqb0jx5U=; b=XDp39fPTDNjhi8vl5c3+HorGD1
	GEfoIeDYUsCiV5PWAZpDEyHksX1ib0fqfJgKJc2T7ZFWMVbqrDjyuyMv71P4UmK9G4t5b27Xcl3k9
	mcatFA9NZluFfNaDezqNv55Ofvi7J/0NbN3ACqpa4Ly2aWXZA9VD0PdOve4gykGCE0BiXk+sCoO2D
	EPSuGT6x0ww3NZY+Cn9gOW3BtMzvcsyQe/iRszL5rtByiD5K/lqaSXaF/2K8JosLQ6cKkslNcEDPO
	Uh8FhPMX5UCqTduA8NgTEmSz/1suFZVsdD6KPvUNLKWeGEAauT5/qu3LTV8yXwRCPDKjaESSqoV/b
	VbeV0KnQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl8DW-0000000GN25-3Pgu;
	Wed, 28 Jan 2026 16:16:31 +0000
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
Subject: [PATCH 11/15] iomap: allow file systems to hook into buffered read bio submission
Date: Wed, 28 Jan 2026 17:15:06 +0100
Message-ID: <20260128161517.666412-12-hch@lst.de>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[suse.com:server fail,infradead.org:server fail,lst.de:server fail,sin.lore.kernel.org:server fail,samsung.com:server fail];
	TAGGED_FROM(0.00)[bounces-75762-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,lst.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,infradead.org:dkim,samsung.com:email,suse.com:email]
X-Rspamd-Queue-Id: 3806CA60D4
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
index 673d7bf8803f..42d562e55d3d 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -489,6 +489,7 @@ struct iomap_read_folio_ctx {
 	struct folio		*cur_folio;
 	struct readahead_control *rac;
 	void			*read_ctx;
+	loff_t			read_ctx_file_offset;
 };
 
 struct iomap_read_ops {
@@ -595,6 +596,9 @@ int iomap_swapfile_activate(struct swap_info_struct *sis,
 extern struct bio_set iomap_ioend_bioset;
 
 #ifdef CONFIG_BLOCK
+int iomap_bio_read_folio_range(const struct iomap_iter *iter,
+		struct iomap_read_folio_ctx *ctx, size_t plen);
+
 extern const struct iomap_read_ops iomap_bio_read_ops;
 
 static inline void iomap_bio_read_folio(struct folio *folio,
-- 
2.47.3


