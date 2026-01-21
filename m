Return-Path: <linux-fsdevel+bounces-74805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QA74J+l2cGktYAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 07:49:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 569FC52569
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 07:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 324947275FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 06:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A1744CF42;
	Wed, 21 Jan 2026 06:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rH+MK3ZW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C03B44BCAD;
	Wed, 21 Jan 2026 06:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768977871; cv=none; b=lCK3Fi2hponLK0ys5NVtx+EK+9Io+7L98NCo3od1Kx5M2DhPrw/i/wje6XXffM3K5IUjjehQnOR00Oa9joYFIJowo+qe8cpcZgLDk/DhY/433pBqGCz4HGAX/CoVYoIkC0cS0tPZAh0ziowk1Nfe/JJxdfiknUR0gfVhpGtknJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768977871; c=relaxed/simple;
	bh=LRq/+MNYvuG2pMQxuVOSJ1/yAy00GR3m5DHtyk4YUJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDc3b9mRady3VC19A7mQw362JOKTsoD51V4BlEbxwgvb0jmikhpOyRgNkbCCoGtO0y50dySP2QsraYZtJxpPSp8/ZRJJp55DMF81Ztcs7kiEITTK27O411qJAc2pZ7MKvXb9KpxkQvB1vgaR/0lQPuQ1mwmK1W8ZpYoKIb7/c30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rH+MK3ZW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=YiVI/cs3YVoQ9BJeu1DmiyWDYTXAmx5Wzgk55L1Ea98=; b=rH+MK3ZWwkF0c/+dm2mfUmck1G
	8VeoNFuyrqqgcRElILl1ywtW22l7CEGM84JPfJ487nRvETOouecrnnGEk7m9hV+UcO42+S4WAtN0Z
	lD/kSW0pqqmoA886l4LFxgXLKVOQcd6zPVhF/uPlUz95x1WFsPFhpDapIpRLfKObYXO1XijqGDqh+
	rkkegZuuBHhczp0NS01ZXG1qwZv0m7D1yWl6zAOaZEPGM8NGUzMQKOmz/wb5BLLD1hJz/HDQC0WPj
	WvWT7J0rPwanG5C5sCTFrvC+jMuZMCINhjnqqug0/RDzKxghf0J8nb71unzSoxMTqhpqXgzyLUQR0
	ETtKDE2A==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viRx6-00000004xai-2eeA;
	Wed, 21 Jan 2026 06:44:28 +0000
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
Date: Wed, 21 Jan 2026 07:43:17 +0100
Message-ID: <20260121064339.206019-10-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-74805-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 569FC52569
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This provides additional context for file systems.

Rename the fuse instance to match the method name while we're at it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/fuse/file.c         | 5 +++--
 fs/iomap/bio.c         | 3 ++-
 fs/iomap/buffered-io.c | 4 ++--
 include/linux/iomap.h  | 3 ++-
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 01bc894e9c2b..99b79dc876ea 100644
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
index 6beb876658c0..4a15c6c153c4 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -573,7 +573,7 @@ void iomap_read_folio(const struct iomap_ops *ops,
 				&bytes_submitted);
 
 	if (ctx->ops->submit_read)
-		ctx->ops->submit_read(ctx);
+		ctx->ops->submit_read(&iter, ctx);
 
 	iomap_read_end(folio, bytes_submitted);
 }
@@ -637,7 +637,7 @@ void iomap_readahead(const struct iomap_ops *ops,
 					&cur_bytes_submitted);
 
 	if (ctx->ops->submit_read)
-		ctx->ops->submit_read(ctx);
+		ctx->ops->submit_read(&iter, ctx);
 
 	if (ctx->cur_folio)
 		iomap_read_end(ctx->cur_folio, cur_bytes_submitted);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index ea79ca9c2d6b..bf6280fc51af 100644
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


