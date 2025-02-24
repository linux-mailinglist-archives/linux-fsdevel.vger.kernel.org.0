Return-Path: <linux-fsdevel+bounces-42423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E7DA42466
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 15:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FD193AF4DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 14:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7D2233729;
	Mon, 24 Feb 2025 14:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="axGb5+c/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB6621930E
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 14:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408326; cv=none; b=YygU06EBusiJ48rbTzLehfFJyKeE6h/X6c4C9Ry/8CLohiuYtMLthDGHTfG5g4bDO8trKQUQXq73R0+z4J0wOSkU+tXi7NzIyh8rGyzipdKVQVf1dzfJgdRSw6TVkD52mPMw6Ef9JyEfNx5x0zvvYuvsoruU5LIvL7OZnG3E4F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408326; c=relaxed/simple;
	bh=J6v0jLZHzgOi6oeCFxC+TpH5dmSldJL+vPg+fJK8idk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o6TndlGXp3iPw6Ol8K2AF7h6yKvZv+spG/z8nuls6P8fjDgpUO530jyEKg0hE6eB7t87ZXCVDIExglDDvLP+547tU9hdTIWgJsPIEenKVfE6rBrQKnwEQJPoiPtaUQ8DgU+LLKzJEmdWQXmPGsSF6VJrToahCwxVao3TsV+jYu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=axGb5+c/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740408323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bIB6w37jITxip7zM1tBxCwmWNGYL+g3gx7Z4pIuftCM=;
	b=axGb5+c/sMx/ZCW6rL8cfzGU1LmsGZtLfR+IOrIyFNnGhONhXE1HbM695N2dxCYb9MpPx4
	KsHa4sIDU2blsRX56Mum1rCLIDJ8qHUbm+w5XlIJ4K0j6ZSF2satYBSTDX/PRThh69/QIJ
	N5dmOGHz71eViPQzlPUp/gdN7kYIkxE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-260-kWM4EDWtOhWYn3i5ep523A-1; Mon,
 24 Feb 2025 09:45:21 -0500
X-MC-Unique: kWM4EDWtOhWYn3i5ep523A-1
X-Mimecast-MFC-AGG-ID: kWM4EDWtOhWYn3i5ep523A_1740408320
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 93BF3190E0B8;
	Mon, 24 Feb 2025 14:45:20 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.79])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ABC8F19560AB;
	Mon, 24 Feb 2025 14:45:19 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v3 01/12] iomap: advance the iter directly on buffered read
Date: Mon, 24 Feb 2025 09:47:46 -0500
Message-ID: <20250224144757.237706-2-bfoster@redhat.com>
In-Reply-To: <20250224144757.237706-1-bfoster@redhat.com>
References: <20250224144757.237706-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

iomap buffered read advances the iter via iter.processed. To
continue separating iter advance from return status, update
iomap_readpage_iter() to advance the iter instead of returning the
number of bytes processed. In turn, drop the offset parameter and
sample the updated iter->pos at the start of the function. Update
the callers to loop based on remaining length in the current
iteration instead of number of bytes processed.

Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 45 +++++++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 8368a4ae716f..582a64f565e6 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -362,15 +362,14 @@ static inline bool iomap_block_needs_zeroing(const struct iomap_iter *iter,
 		pos >= i_size_read(iter->inode);
 }
 
-static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
-		struct iomap_readpage_ctx *ctx, loff_t offset)
+static loff_t iomap_readpage_iter(struct iomap_iter *iter,
+		struct iomap_readpage_ctx *ctx)
 {
 	const struct iomap *iomap = &iter->iomap;
-	loff_t pos = iter->pos + offset;
-	loff_t length = iomap_length(iter) - offset;
+	loff_t pos = iter->pos;
+	loff_t length = iomap_length(iter);
 	struct folio *folio = ctx->cur_folio;
 	struct iomap_folio_state *ifs;
-	loff_t orig_pos = pos;
 	size_t poff, plen;
 	sector_t sector;
 
@@ -434,25 +433,22 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 	 * we can skip trailing ones as they will be handled in the next
 	 * iteration.
 	 */
-	return pos - orig_pos + plen;
+	length = pos - iter->pos + plen;
+	return iomap_iter_advance(iter, &length);
 }
 
-static loff_t iomap_read_folio_iter(const struct iomap_iter *iter,
+static loff_t iomap_read_folio_iter(struct iomap_iter *iter,
 		struct iomap_readpage_ctx *ctx)
 {
-	struct folio *folio = ctx->cur_folio;
-	size_t offset = offset_in_folio(folio, iter->pos);
-	loff_t length = min_t(loff_t, folio_size(folio) - offset,
-			      iomap_length(iter));
-	loff_t done, ret;
-
-	for (done = 0; done < length; done += ret) {
-		ret = iomap_readpage_iter(iter, ctx, done);
-		if (ret <= 0)
+	loff_t ret;
+
+	while (iomap_length(iter)) {
+		ret = iomap_readpage_iter(iter, ctx);
+		if (ret)
 			return ret;
 	}
 
-	return done;
+	return 0;
 }
 
 int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
@@ -489,15 +485,14 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 }
 EXPORT_SYMBOL_GPL(iomap_read_folio);
 
-static loff_t iomap_readahead_iter(const struct iomap_iter *iter,
+static loff_t iomap_readahead_iter(struct iomap_iter *iter,
 		struct iomap_readpage_ctx *ctx)
 {
-	loff_t length = iomap_length(iter);
-	loff_t done, ret;
+	loff_t ret;
 
-	for (done = 0; done < length; done += ret) {
+	while (iomap_length(iter)) {
 		if (ctx->cur_folio &&
-		    offset_in_folio(ctx->cur_folio, iter->pos + done) == 0) {
+		    offset_in_folio(ctx->cur_folio, iter->pos) == 0) {
 			if (!ctx->cur_folio_in_bio)
 				folio_unlock(ctx->cur_folio);
 			ctx->cur_folio = NULL;
@@ -506,12 +501,12 @@ static loff_t iomap_readahead_iter(const struct iomap_iter *iter,
 			ctx->cur_folio = readahead_folio(ctx->rac);
 			ctx->cur_folio_in_bio = false;
 		}
-		ret = iomap_readpage_iter(iter, ctx, done);
-		if (ret <= 0)
+		ret = iomap_readpage_iter(iter, ctx);
+		if (ret)
 			return ret;
 	}
 
-	return done;
+	return 0;
 }
 
 /**
-- 
2.48.1


