Return-Path: <linux-fsdevel+bounces-47746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6C0AA5452
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 20:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BCA1189807A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 18:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95BF26FA67;
	Wed, 30 Apr 2025 18:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dcakRPzn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF12264F81
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 18:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746039490; cv=none; b=ZMuUr7cF7TtL14YDhs7pbm0vA6y6+zifqUEMjyIILg7b6IhX7FLRYH8w1tMDD/igsvBZsxhXWed1BS6Bq+h58KwReRiTzUXODFAwQp024UUxOWbI2HYiFgjM7AKVg24dr5Kk+oQ++awi7g2NQZGtY1M/4hsmwS1oeLJjnVAp+eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746039490; c=relaxed/simple;
	bh=Qu0WUmvAIXfSN1oTNHHR/C3j+3C1oAmn/RhhPx7BCz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DaDbegioBHRRjkuPw+hsbIDSC7DcxZzR3xZUwNLdyPGGizhiHq7HSuW6kE4mZugU1XICJ/UtTcfkx26CFBy5uUqvYknQtbKc1CxaUaWUOqfMGPtqxQm/k0WrgfNlTnw1nhoRRSqAYtubFLnPlvRqU1/0Zm8iQ8CF0p97xOPyZYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dcakRPzn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746039487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wJPFAjXe1skE3jhAjmdy+Rx8bimxov2Shr3PrIMveHE=;
	b=dcakRPznxJ1TNXwXFLycYRvFNI72IuQXE0vFwTHc/X2RpCK2f+qH/3KXcIcHkDx/xX4eJY
	Czr07NfajiMlYN2AlPP7u+zjuSbLFdBJUkPP0ud/xHHqnrH8z3wZoIdkUts6AQI0C/6bca
	/nNGOCEzVV/RvKzeXB2vohkK+jOMXeo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-108-4czLJh98OWW1UjXsTsxOJw-1; Wed,
 30 Apr 2025 14:58:05 -0400
X-MC-Unique: 4czLJh98OWW1UjXsTsxOJw-1
X-Mimecast-MFC-AGG-ID: 4czLJh98OWW1UjXsTsxOJw_1746039484
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD1C71955E87;
	Wed, 30 Apr 2025 18:58:04 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.64.112])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 04B5B19560A3;
	Wed, 30 Apr 2025 18:58:03 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org
Subject: [PATCH 6/6] iomap: rework iomap_write_begin() to return folio offset and length
Date: Wed, 30 Apr 2025 15:01:12 -0400
Message-ID: <20250430190112.690800-7-bfoster@redhat.com>
In-Reply-To: <20250430190112.690800-1-bfoster@redhat.com>
References: <20250430190112.690800-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

iomap_write_begin() returns a folio based on current pos and
remaining length in the iter, and each caller then trims the
pos/length to the given folio. Clean this up a bit and let
iomap_write_begin() return the trimmed range along with the folio.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/iomap/buffered-io.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d3b30ebad9ea..2fde268c39fc 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -793,15 +793,22 @@ static int iomap_write_begin_inline(const struct iomap_iter *iter,
 	return iomap_read_inline_data(iter, folio);
 }
 
-static int iomap_write_begin(struct iomap_iter *iter, size_t len,
-		struct folio **foliop)
+/*
+ * Grab and prepare a folio for write based on iter state. Returns the folio,
+ * offset, and length. Callers can optionally pass a max length *plen,
+ * otherwise init to zero.
+ */
+static int iomap_write_begin(struct iomap_iter *iter, struct folio **foliop,
+		size_t *poffset, u64 *plen)
 {
 	const struct iomap_folio_ops *folio_ops = iter->iomap.folio_ops;
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	loff_t pos = iter->pos;
+	u64 len = min_t(u64, SIZE_MAX, iomap_length(iter));
 	struct folio *folio;
 	int status = 0;
 
+	len = *plen > 0 ? min_t(u64, len, *plen) : len;
 	BUG_ON(pos + len > iter->iomap.offset + iter->iomap.length);
 	if (srcmap != &iter->iomap)
 		BUG_ON(pos + len > srcmap->offset + srcmap->length);
@@ -833,8 +840,7 @@ static int iomap_write_begin(struct iomap_iter *iter, size_t len,
 		}
 	}
 
-	if (pos + len > folio_pos(folio) + folio_size(folio))
-		len = folio_pos(folio) + folio_size(folio) - pos;
+	pos = iomap_trim_folio_range(iter, folio, poffset, &len);
 
 	if (srcmap->type == IOMAP_INLINE)
 		status = iomap_write_begin_inline(iter, folio);
@@ -847,6 +853,7 @@ static int iomap_write_begin(struct iomap_iter *iter, size_t len,
 		goto out_unlock;
 
 	*foliop = folio;
+	*plen = len;
 	return 0;
 
 out_unlock:
@@ -967,7 +974,7 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 			break;
 		}
 
-		status = iomap_write_begin(iter, bytes, &folio);
+		status = iomap_write_begin(iter, &folio, &offset, &bytes);
 		if (unlikely(status)) {
 			iomap_write_failed(iter->inode, iter->pos, bytes);
 			break;
@@ -975,7 +982,7 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 		if (iter->iomap.flags & IOMAP_F_STALE)
 			break;
 
-		pos = iomap_trim_folio_range(iter, folio, &offset, &bytes);
+		pos = iter->pos;
 
 		if (mapping_writably_mapped(mapping))
 			flush_dcache_folio(folio);
@@ -1295,14 +1302,12 @@ static int iomap_unshare_iter(struct iomap_iter *iter)
 		bool ret;
 
 		bytes = min_t(u64, SIZE_MAX, bytes);
-		status = iomap_write_begin(iter, bytes, &folio);
+		status = iomap_write_begin(iter, &folio, &offset, &bytes);
 		if (unlikely(status))
 			return status;
 		if (iomap->flags & IOMAP_F_STALE)
 			break;
 
-		iomap_trim_folio_range(iter, folio, &offset, &bytes);
-
 		ret = iomap_write_end(iter, bytes, bytes, folio);
 		__iomap_put_folio(iter, bytes, folio);
 		if (WARN_ON_ONCE(!ret))
@@ -1367,7 +1372,7 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		bool ret;
 
 		bytes = min_t(u64, SIZE_MAX, bytes);
-		status = iomap_write_begin(iter, bytes, &folio);
+		status = iomap_write_begin(iter, &folio, &offset, &bytes);
 		if (status)
 			return status;
 		if (iter->iomap.flags & IOMAP_F_STALE)
@@ -1376,7 +1381,6 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		/* warn about zeroing folios beyond eof that won't write back */
 		WARN_ON_ONCE(folio_pos(folio) > iter->inode->i_size);
 
-		iomap_trim_folio_range(iter, folio, &offset, &bytes);
 		folio_zero_range(folio, offset, bytes);
 		folio_mark_accessed(folio);
 
-- 
2.49.0


