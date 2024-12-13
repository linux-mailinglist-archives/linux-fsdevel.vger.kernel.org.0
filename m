Return-Path: <linux-fsdevel+bounces-37323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D039F102C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 16:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D86B282B2A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 15:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1561E32BF;
	Fri, 13 Dec 2024 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LvcGqtPS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBE81E231D
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 15:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102229; cv=none; b=Vt3j4IWuo6ii5d/YecG2Kd+KlB13aFZ9a+TWLDZG8/54vqfnkUupkuOn+FxbDondWwrUm7eO0jckKtf9hxv20rnGjj7MWhX5OqpjKOmHzlQ4l+dxPl1lU+mvUwyOOyn71D1VYiH7HAf5L20/fRblGHGtGa8vWIY3o2AEuByAQJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102229; c=relaxed/simple;
	bh=KaiRfniO8ypmC9LnN8mkDxYIOrzwWRP4c6dpRh53d/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fW4WlM37geXwj+vEeHcNMP6Ec/I1CuHnlheGExarYCp8PaxNWBjmfuudMSDIV8RavY2mAr9bEiHniPpu0DWJOKRBScu1RZfzi7KrGYDmz81zJFHquZufy9HFuFAjMPV97jPW34iogBa1b14V0Dw1e42mys4ObersBDTkwhN30PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LvcGqtPS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734102226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lqFX0oyHRDEmE94Jp5u6aCubudExYzqG6Xpe0M6XTQQ=;
	b=LvcGqtPSg68EJQS6GQbLwzd8ZpwTmPZxQEkg5Irnk8U7boTQoXLKiw2XVLoJCI/oXlYPq9
	iqbzt4Dsr0dfIaHRPiYKX1JmMdZ9zD+cHYVj81vG4/msFaYTrlm7s5qHtvuDKCHWAuCLIU
	+bIY4Azl2NfUs7AdlEXlwYK/7sy18a8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480-HZsnzgIdOmqrq_GrixwtdA-1; Fri,
 13 Dec 2024 10:03:43 -0500
X-MC-Unique: HZsnzgIdOmqrq_GrixwtdA-1
X-Mimecast-MFC-AGG-ID: HZsnzgIdOmqrq_GrixwtdA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A0A7C1955E91;
	Fri, 13 Dec 2024 15:03:42 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.90.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 09E1F1953951;
	Fri, 13 Dec 2024 15:03:41 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org
Subject: [PATCH RFCv2 1/4] iomap: prep work for folio_batch support
Date: Fri, 13 Dec 2024 10:05:25 -0500
Message-ID: <20241213150528.1003662-2-bfoster@redhat.com>
In-Reply-To: <20241213150528.1003662-1-bfoster@redhat.com>
References: <20241213150528.1003662-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Squash of misc. prep work for folio_batch support.

Not-Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/iomap/buffered-io.c | 100 +++++++++++++++++++++++------------------
 1 file changed, 57 insertions(+), 43 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index e0ae46b11413..7fdf593b58b1 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -743,10 +743,13 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 	return 0;
 }
 
-static struct folio *__iomap_get_folio(struct iomap_iter *iter, loff_t pos,
-		size_t len)
+static struct folio *__iomap_get_folio(struct iomap_iter *iter, size_t len)
 {
 	const struct iomap_folio_ops *folio_ops = iter->iomap.folio_ops;
+	loff_t pos = iter->pos;
+
+	if (!mapping_large_folio_support(iter->inode->i_mapping))
+		len = min_t(size_t, len, PAGE_SIZE - offset_in_page(pos));
 
 	if (folio_ops && folio_ops->get_folio)
 		return folio_ops->get_folio(iter, pos, len);
@@ -754,10 +757,11 @@ static struct folio *__iomap_get_folio(struct iomap_iter *iter, loff_t pos,
 		return iomap_get_folio(iter, pos, len);
 }
 
-static void __iomap_put_folio(struct iomap_iter *iter, loff_t pos, size_t ret,
+static void __iomap_put_folio(struct iomap_iter *iter, size_t ret,
 		struct folio *folio)
 {
 	const struct iomap_folio_ops *folio_ops = iter->iomap.folio_ops;
+	loff_t pos = iter->pos;
 
 	if (folio_ops && folio_ops->put_folio) {
 		folio_ops->put_folio(iter->inode, pos, ret, folio);
@@ -767,6 +771,21 @@ static void __iomap_put_folio(struct iomap_iter *iter, loff_t pos, size_t ret,
 	}
 }
 
+/* trim pos and bytes to within a given folio */
+static loff_t iomap_trim_folio_range(struct iomap_iter *iter,
+		struct folio *folio, size_t *offset, size_t *bytes)
+{
+	loff_t pos = iter->pos;
+	size_t fsize = folio_size(folio);
+
+	WARN_ON_ONCE(pos < folio_pos(folio) || pos >= folio_pos(folio) + fsize);
+
+	*offset = offset_in_folio(folio, pos);
+	if (*bytes > fsize - *offset)
+		*bytes = fsize - *offset;
+	return pos;
+}
+
 static int iomap_write_begin_inline(const struct iomap_iter *iter,
 		struct folio *folio)
 {
@@ -776,25 +795,27 @@ static int iomap_write_begin_inline(const struct iomap_iter *iter,
 	return iomap_read_inline_data(iter, folio);
 }
 
-static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
-		size_t len, struct folio **foliop)
+/*
+ * Grab and prepare a folio for write based on iter state. Returns the folio,
+ * offset, and length. Callers can optionally pass a max length *plen,
+ * otherwise init to zero.
+ */
+static int iomap_write_begin(struct iomap_iter *iter, struct folio **foliop,
+		size_t *poffset, size_t *plen)
 {
 	const struct iomap_folio_ops *folio_ops = iter->iomap.folio_ops;
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
+	loff_t pos;
+	size_t len = min_t(u64, SIZE_MAX, iomap_length(iter));
 	struct folio *folio;
 	int status = 0;
 
-	BUG_ON(pos + len > iter->iomap.offset + iter->iomap.length);
-	if (srcmap != &iter->iomap)
-		BUG_ON(pos + len > srcmap->offset + srcmap->length);
+	len = *plen > 0 ? min_t(u64, len, *plen) : len;
 
 	if (fatal_signal_pending(current))
 		return -EINTR;
 
-	if (!mapping_large_folio_support(iter->inode->i_mapping))
-		len = min_t(size_t, len, PAGE_SIZE - offset_in_page(pos));
-
-	folio = __iomap_get_folio(iter, pos, len);
+	folio = __iomap_get_folio(iter, len);
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
 
@@ -818,8 +839,10 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
 		}
 	}
 
-	if (pos + len > folio_pos(folio) + folio_size(folio))
-		len = folio_pos(folio) + folio_size(folio) - pos;
+	pos = iomap_trim_folio_range(iter, folio, poffset, &len);
+	BUG_ON(pos + len > iter->iomap.offset + iter->iomap.length);
+	if (srcmap != &iter->iomap)
+		BUG_ON(pos + len > srcmap->offset + srcmap->length);
 
 	if (srcmap->type == IOMAP_INLINE)
 		status = iomap_write_begin_inline(iter, folio);
@@ -832,10 +855,11 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
 		goto out_unlock;
 
 	*foliop = folio;
+	*plen = len;
 	return 0;
 
 out_unlock:
-	__iomap_put_folio(iter, pos, 0, folio);
+	__iomap_put_folio(iter, 0, folio);
 
 	return status;
 }
@@ -885,10 +909,11 @@ static void iomap_write_end_inline(const struct iomap_iter *iter,
  * Returns true if all copied bytes have been written to the pagecache,
  * otherwise return false.
  */
-static bool iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
-		size_t copied, struct folio *folio)
+static bool iomap_write_end(struct iomap_iter *iter, size_t len, size_t copied,
+		struct folio *folio)
 {
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
+	loff_t pos = iter->pos;
 
 	if (srcmap->type == IOMAP_INLINE) {
 		iomap_write_end_inline(iter, folio, pos, copied);
@@ -922,12 +947,12 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 		size_t bytes;		/* Bytes to write to folio */
 		size_t copied;		/* Bytes copied from user */
 		size_t written;		/* Bytes have been written */
-		loff_t pos = iter->pos;
+		loff_t pos;
 		loff_t length = iomap_length(iter);
 
 		bytes = iov_iter_count(i);
 retry:
-		offset = pos & (chunk - 1);
+		offset = iter->pos & (chunk - 1);
 		bytes = min(chunk - offset, bytes);
 		status = balance_dirty_pages_ratelimited_flags(mapping,
 							       bdp_flags);
@@ -952,23 +977,21 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 			break;
 		}
 
-		status = iomap_write_begin(iter, pos, bytes, &folio);
+		status = iomap_write_begin(iter, &folio, &offset, &bytes);
 		if (unlikely(status)) {
-			iomap_write_failed(iter->inode, pos, bytes);
+			iomap_write_failed(iter->inode, iter->pos, bytes);
 			break;
 		}
 		if (iter->iomap.flags & IOMAP_F_STALE)
 			break;
 
-		offset = offset_in_folio(folio, pos);
-		if (bytes > folio_size(folio) - offset)
-			bytes = folio_size(folio) - offset;
+		pos = iter->pos;
 
 		if (mapping_writably_mapped(mapping))
 			flush_dcache_folio(folio);
 
 		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
-		written = iomap_write_end(iter, pos, bytes, copied, folio) ?
+		written = iomap_write_end(iter, bytes, copied, folio) ?
 			  copied : 0;
 
 		/*
@@ -983,7 +1006,7 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 			i_size_write(iter->inode, pos + written);
 			iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
 		}
-		__iomap_put_folio(iter, pos, written, folio);
+		__iomap_put_folio(iter, written, folio);
 
 		if (old_size < pos)
 			pagecache_isize_extended(iter->inode, old_size, pos);
@@ -1276,22 +1299,17 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
 		struct folio *folio;
 		int status;
 		size_t offset;
-		size_t bytes = min_t(u64, SIZE_MAX, iomap_length(iter));
-		loff_t pos = iter->pos;
+		size_t bytes = 0;
 		bool ret;
 
-		status = iomap_write_begin(iter, pos, bytes, &folio);
+		status = iomap_write_begin(iter, &folio, &offset, &bytes);
 		if (unlikely(status))
 			return status;
 		if (iomap->flags & IOMAP_F_STALE)
 			break;
 
-		offset = offset_in_folio(folio, pos);
-		if (bytes > folio_size(folio) - offset)
-			bytes = folio_size(folio) - offset;
-
-		ret = iomap_write_end(iter, pos, bytes, bytes, folio);
-		__iomap_put_folio(iter, pos, bytes, folio);
+		ret = iomap_write_end(iter, bytes, bytes, folio);
+		__iomap_put_folio(iter, bytes, folio);
 		if (WARN_ON_ONCE(!ret))
 			return -EIO;
 
@@ -1347,11 +1365,10 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		struct folio *folio;
 		int status;
 		size_t offset;
-		size_t bytes = min_t(u64, SIZE_MAX, iomap_length(iter));
-		loff_t pos = iter->pos;
+		size_t bytes = 0;
 		bool ret;
 
-		status = iomap_write_begin(iter, pos, bytes, &folio);
+		status = iomap_write_begin(iter, &folio, &offset, &bytes);
 		if (status)
 			return status;
 		if (iter->iomap.flags & IOMAP_F_STALE)
@@ -1359,15 +1376,12 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 
 		/* warn about zeroing folios beyond eof that won't write back */
 		WARN_ON_ONCE(folio_pos(folio) > iter->inode->i_size);
-		offset = offset_in_folio(folio, pos);
-		if (bytes > folio_size(folio) - offset)
-			bytes = folio_size(folio) - offset;
 
 		folio_zero_range(folio, offset, bytes);
 		folio_mark_accessed(folio);
 
-		ret = iomap_write_end(iter, pos, bytes, bytes, folio);
-		__iomap_put_folio(iter, pos, bytes, folio);
+		ret = iomap_write_end(iter, bytes, bytes, folio);
+		__iomap_put_folio(iter, bytes, folio);
 		if (WARN_ON_ONCE(!ret))
 			return -EIO;
 
-- 
2.47.0


