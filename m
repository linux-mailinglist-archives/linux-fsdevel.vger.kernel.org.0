Return-Path: <linux-fsdevel+bounces-77508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCV6JRxZlWnQPAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 07:15:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C431534DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 07:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 286B63076E4B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 06:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B72930B524;
	Wed, 18 Feb 2026 06:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pHLaExOt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198EB3081D2;
	Wed, 18 Feb 2026 06:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771395217; cv=none; b=Ng69v9IpV3fg04qbKPwsHyXtO4N/KbnlM1MZ9e47/VshUjitFVj/Oe9Q158WEQunehcCdeWmuzoW+BWFBqAI9VCu4Be1xGaJmz0mPVLEx+u1kbN1Sc87c9RqQkjLGn5aUDhnMgbWjAKW+qKLWQJgA101Y0yA/3h0jDLKEHAZWHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771395217; c=relaxed/simple;
	bh=vk8Aw161FAgqq2Ozrmz5lh2e0KwLYdOqc166zSjwuR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eU6pVkTJQpPR+GsSr1+5wzLJCQznfCwqU6+fYCSWQGfnRtawsqYv278zjfatspf1aMEwpusDU+1GsDQCenVETGEV1U2+m+t60UWzIxUUcBYxgpZ+EaNSj5XRm6AB5Ucrng7KSommPDIsW/ZAI4xxTLnC7WB7/wWVWIcYe/80QD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pHLaExOt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Nbr6hGIXiHKWxhKFa6dcKpE3lK3nHiEj5FiJ3blIT/c=; b=pHLaExOt2oeqfCYX38USy4c4iZ
	+E6M9jZowInX3aY4VUpNQUAsLWmSWvEIYM76hXP83rIDJ/S+PEfB/M02Uj02o703bbq3qJPlcJFER
	VeGdgF05YcZpZPLFwMnXijIKCmrLohBgTvKfb3MfnN3AapwvRTSrUPTFxi4irQuycbzFM5N72XA8r
	R+ysvdNx70lDWYIft5j8fGbah5nJx6fw5u5sO70cThwir8PjbPgSVumjqr0OLNt7Xw2SOpGty9Sk8
	q94BOpgBis8bnnlv12H5z84SCM+gHav/+jHHIZSg1nVVyqN+gYEMVLO5u/d0sm8F/ZVq0U0YxxMDB
	Vd18mxiw==;
Received: from [2001:4bb8:2dc:9863:1842:9381:9c0f:de32] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsaoY-00000009LUE-3Oj1;
	Wed, 18 Feb 2026 06:13:35 +0000
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
Subject: [PATCH 10/15] iomap: only call into ->submit_read when there is a read_ctx
Date: Wed, 18 Feb 2026 07:12:04 +0100
Message-ID: <20260218061238.3317841-11-hch@lst.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77508-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,lst.de:email,infradead.org:dkim,samsung.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 05C431534DB
X-Rspamd-Action: no action

Move the NULL check into the callers to simplify the callees.

Fuse was missing this before, but has a constant read_ctx that is
never NULL or changed, so no change here either.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Tested-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/iomap/bio.c         | 5 +----
 fs/iomap/buffered-io.c | 4 ++--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/bio.c b/fs/iomap/bio.c
index cb60d1facb5a..80bbd328bd3c 100644
--- a/fs/iomap/bio.c
+++ b/fs/iomap/bio.c
@@ -21,10 +21,7 @@ static void iomap_read_end_io(struct bio *bio)
 static void iomap_bio_submit_read(const struct iomap_iter *iter,
 		struct iomap_read_folio_ctx *ctx)
 {
-	struct bio *bio = ctx->read_ctx;
-
-	if (bio)
-		submit_bio(bio);
+	submit_bio(ctx->read_ctx);
 }
 
 static void iomap_read_alloc_bio(const struct iomap_iter *iter,
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 2fd628deb5e2..4f10359b78be 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -588,7 +588,7 @@ void iomap_read_folio(const struct iomap_ops *ops,
 		iter.status = iomap_read_folio_iter(&iter, ctx,
 				&bytes_submitted);
 
-	if (ctx->ops->submit_read)
+	if (ctx->read_ctx && ctx->ops->submit_read)
 		ctx->ops->submit_read(&iter, ctx);
 
 	if (ctx->cur_folio)
@@ -654,7 +654,7 @@ void iomap_readahead(const struct iomap_ops *ops,
 		iter.status = iomap_readahead_iter(&iter, ctx,
 					&cur_bytes_submitted);
 
-	if (ctx->ops->submit_read)
+	if (ctx->read_ctx && ctx->ops->submit_read)
 		ctx->ops->submit_read(&iter, ctx);
 
 	if (ctx->cur_folio)
-- 
2.47.3


