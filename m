Return-Path: <linux-fsdevel+bounces-42098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 994FDA3C689
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 18:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D5FB179979
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 17:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2751BCA19;
	Wed, 19 Feb 2025 17:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HiCKJsQw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967EB126BFA
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2025 17:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987300; cv=none; b=Wh60TJnR2uBUXoqC1leVFYCFgeYv6FOAnGRoCeryt8FVb493tuS5m+37oEtUq4hSnJqSnHCYIdBCKX/dSHj9AGiJ+U0h+//c5JzrGMlDJuqScVLtK432jRW2RAzWTk5aTYZ9DxvXtEqSUFEyfXbnp+mlLkANjm9Pe/ILTh4EleA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987300; c=relaxed/simple;
	bh=ChBLLhKdQDy4iV7vOf6HaCQaRXywHgk8CXdKB8yQPRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CGZDhvBoi/s+yjrFsnehvdPJ+oMkVlvSSU49xcxfk4Jm88uKGS2dbpVGIXA+F/i3KU8oyd1aDUZMI+UxchafkGZMrAyrat+D+jlGsiLPS/EQyILxOEX3jgatCpNg7eC1r4kHfTZWMaHuFIhJYVGwjmzhxptYQljTUldOnUawJvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HiCKJsQw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739987297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j/t9wn/bg8lmLxMOZFGrMW/wk88qhDNztSfUbuyHRkI=;
	b=HiCKJsQwzhTTCa96fAwWtYjEUL0mlg32UlY+RfMBMSpcdSAB6a1wm/3i/Oq/mraIUIkCg1
	6o8zs61MyIdpcz6DkGqFxgFJTDPrCrtwaUsxU4P5CZIQSHFuzfNbrdy6PNecIQCX1UiBoa
	QKMhckod/gL0c+qGRfisuy2Q0HzwMRI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-CB43uMniOkG_uE9Q39GAvA-1; Wed,
 19 Feb 2025 12:48:15 -0500
X-MC-Unique: CB43uMniOkG_uE9Q39GAvA-1
X-Mimecast-MFC-AGG-ID: CB43uMniOkG_uE9Q39GAvA_1739987294
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 932E918EB2C9;
	Wed, 19 Feb 2025 17:48:14 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.79])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7841E1800D9B;
	Wed, 19 Feb 2025 17:48:13 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v2 01/12] iomap: advance the iter directly on buffered read
Date: Wed, 19 Feb 2025 12:50:39 -0500
Message-ID: <20250219175050.83986-2-bfoster@redhat.com>
In-Reply-To: <20250219175050.83986-1-bfoster@redhat.com>
References: <20250219175050.83986-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

iomap buffered read advances the iter via iter.processed. To
continue separating iter advance from return status, update
iomap_readpage_iter() to advance the iter instead of returning the
number of bytes processed. In turn, drop the offset parameter and
sample the updated iter->pos at the start of the function. Update
the callers to loop based on remaining length in the current
iteration instead of number of bytes processed.

Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 45 +++++++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index ec227b45f3aa..215866ba264d 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -366,15 +366,14 @@ static inline bool iomap_block_needs_zeroing(const struct iomap_iter *iter,
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
 
@@ -438,25 +437,22 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
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
@@ -493,15 +489,14 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
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
@@ -510,12 +505,12 @@ static loff_t iomap_readahead_iter(const struct iomap_iter *iter,
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


