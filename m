Return-Path: <linux-fsdevel+bounces-77507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CC+LEI9YlWnQPAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 07:13:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BBD1533CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 07:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B68CF301BDE8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 06:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2005B30B518;
	Wed, 18 Feb 2026 06:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UKneTP8G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973563093B8;
	Wed, 18 Feb 2026 06:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771395211; cv=none; b=R1aVJDvr9LjzrSYnujU4gapUxZf77mCngUMEr2WKwz+/TBqQxX28srPV1mNzqHHVDtcLS38IM3QVRKVF9ouEdJ2S9znH0RxztxA1stIq2Bj/emXpa4ceSEgMni6++OnS+tkHdLAKJM5KYnp2ZAHuYjjJuq7HmT6egK4nrM2Q/3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771395211; c=relaxed/simple;
	bh=0n32OSe0NU7mIAy0tufl8ztr7PbNbzORPhLM6f+nqyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqL3JPIQPMJGJ1Yql3LSPsj2CGShYUGv80FhqB8sFSjH7gBLewZ0nXrUlIPi7ha1BqRCjCXn7WIG3ld+56N1OpTFWQb1VJ2VP2EvpVaHldpJUPux+tJRCGIX5MJtDIM7oXup9iaa7n1K6Uw4MIftyBF0RkTt90e3aQYZUpW1zFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UKneTP8G; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=L1m4BlVm5lRwuks//UekvxH6P/tjf5FI64P5jK9TRHQ=; b=UKneTP8GTGjcX5hj4lQ1WOU9Am
	pX5AJYR+yNj3ssiis6qB6sUaFonUxbJs+/LMLtScrGxZHcjI0T90qae5gu/j47k23OkPHV5NslEAl
	v64DARYbeqfuHemQaGJv7Uw40ZAeOpFxGqAoEsQ9yuV91uFxVb4rgitg/BwLmpaZ5dKTkG5vEvi/4
	AkGbdyRLAueOef4haIXEeR6FeVUSNbjpHcb1/f5LKXBIwWGBKi4jYzAU5Xo/IFNMK9FeIPw0GNivH
	4LuUxTe76NbjENE2NiaVaNCQkDzrAKXQLkeaRwl8j9pq9MBcNsLHG7bs/OpL8UPI5u+zuZdzktCHf
	VE/ynl3Q==;
Received: from [2001:4bb8:2dc:9863:1842:9381:9c0f:de32] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsaoT-00000009LTr-0p1J;
	Wed, 18 Feb 2026 06:13:29 +0000
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
Subject: [PATCH 09/15] iomap: pass the iomap_iter to ->submit_read
Date: Wed, 18 Feb 2026 07:12:03 +0100
Message-ID: <20260218061238.3317841-10-hch@lst.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77507-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,lst.de:email,infradead.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D7BBD1533CB
X-Rspamd-Action: no action

This provides additional context for file systems.

Rename the fuse instance to match the method name while we're at it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Tested-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/fuse/file.c         | 5 +++--
 fs/iomap/bio.c         | 3 ++-
 fs/iomap/buffered-io.c | 4 ++--
 include/linux/iomap.h  | 3 ++-
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 80765ab6d04a..4d4fb749a35d 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -947,7 +947,8 @@ static int fuse_iomap_read_folio_range_async(const struct iomap_iter *iter,
 	return ret;
 }
 
-static void fuse_iomap_read_submit(struct iomap_read_folio_ctx *ctx)
+static void fuse_iomap_submit_read(const struct iomap_iter *iter,
+		struct iomap_read_folio_ctx *ctx)
 {
 	struct fuse_fill_read_data *data = ctx->read_ctx;
 
@@ -958,7 +959,7 @@ static void fuse_iomap_read_submit(struct iomap_read_folio_ctx *ctx)
 
 static const struct iomap_read_ops fuse_iomap_read_ops = {
 	.read_folio_range = fuse_iomap_read_folio_range_async,
-	.submit_read = fuse_iomap_read_submit,
+	.submit_read = fuse_iomap_submit_read,
 };
 
 static int fuse_read_folio(struct file *file, struct folio *folio)
diff --git a/fs/iomap/bio.c b/fs/iomap/bio.c
index 578b1202e037..cb60d1facb5a 100644
--- a/fs/iomap/bio.c
+++ b/fs/iomap/bio.c
@@ -18,7 +18,8 @@ static void iomap_read_end_io(struct bio *bio)
 	bio_put(bio);
 }
 
-static void iomap_bio_submit_read(struct iomap_read_folio_ctx *ctx)
+static void iomap_bio_submit_read(const struct iomap_iter *iter,
+		struct iomap_read_folio_ctx *ctx)
 {
 	struct bio *bio = ctx->read_ctx;
 
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 1fe19b4ee2f4..2fd628deb5e2 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -589,7 +589,7 @@ void iomap_read_folio(const struct iomap_ops *ops,
 				&bytes_submitted);
 
 	if (ctx->ops->submit_read)
-		ctx->ops->submit_read(ctx);
+		ctx->ops->submit_read(&iter, ctx);
 
 	if (ctx->cur_folio)
 		iomap_read_end(ctx->cur_folio, bytes_submitted);
@@ -655,7 +655,7 @@ void iomap_readahead(const struct iomap_ops *ops,
 					&cur_bytes_submitted);
 
 	if (ctx->ops->submit_read)
-		ctx->ops->submit_read(ctx);
+		ctx->ops->submit_read(&iter, ctx);
 
 	if (ctx->cur_folio)
 		iomap_read_end(ctx->cur_folio, cur_bytes_submitted);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 99b7209dabd7..6fbe121e2adf 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -512,7 +512,8 @@ struct iomap_read_ops {
 	 *
 	 * This is optional.
 	 */
-	void (*submit_read)(struct iomap_read_folio_ctx *ctx);
+	void (*submit_read)(const struct iomap_iter *iter,
+			struct iomap_read_folio_ctx *ctx);
 };
 
 /*
-- 
2.47.3


