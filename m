Return-Path: <linux-fsdevel+bounces-48253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 564E2AAC69E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 15:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84E863AA6F8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 13:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA2B2820DC;
	Tue,  6 May 2025 13:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uk4uk3Gy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919082820CC
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 May 2025 13:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746538702; cv=none; b=XPWVnGnLJljzw/eD/6AgFOoo6Pt7FUFl8BZ1tEm0mzB4q7ov3gP8ge8LpmmT1fbHfok/ZrVftW87cGVvdyYoeNmWAbSiAs7Vm9/Eyz1Rs/BDGBJdra5S5zJVaiFTXpcV7iLflArf5e26yOdu04vEeH/p6cDnBLj8AtbVs3RMdoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746538702; c=relaxed/simple;
	bh=/Nu5F2hfoVS6a9qODoLnx4ho2+1/HoEm9iGuqlaMr0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d1FZTy2cq5CRKtfjjpoP9HRUyRpUt3NbrXbcJee8RrBSNCT5Way6lJfL8FJ4TwUNbqglKORFzghr/rUIoMIurbrbvKMYz0+2zw6I1cyheXlOk7XPqxgI9a4/RDrWbmJl9/7D9gVxmySC6XuIFVouTYHLsp/jxxE3ZUhjX9phSac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uk4uk3Gy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746538699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S8DFgx2TlyhvPpBgtdzaEeWI42qGd1HZ1wMg88y3UEo=;
	b=Uk4uk3GySxJKcFjwOK0XotR4i5gnwhOhatN2lD9yJXlp5mNcJos3/Vgs8mkY9Rf7R9MRHe
	PyqIKAdG3CBTZD2jbGWiwQEVPBfqQo+HXdI1NG9D5bE4hsQwy7R5b11G5ifL2HRUCn16QT
	px/1f7Altyq3DX29dTnuE2BwWjnuioQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-207-T5WByxOrPk65RDhao0_ogg-1; Tue,
 06 May 2025 09:38:15 -0400
X-MC-Unique: T5WByxOrPk65RDhao0_ogg-1
X-Mimecast-MFC-AGG-ID: T5WByxOrPk65RDhao0_ogg_1746538694
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E31B18009A0;
	Tue,  6 May 2025 13:38:14 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.64.112])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2BBD419560A3;
	Tue,  6 May 2025 13:38:13 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	djwong@kernel.org,
	hch@infradead.org
Subject: [PATCH v2 6/6] iomap: rework iomap_write_begin() to return folio offset and length
Date: Tue,  6 May 2025 09:41:18 -0400
Message-ID: <20250506134118.911396-7-bfoster@redhat.com>
In-Reply-To: <20250506134118.911396-1-bfoster@redhat.com>
References: <20250506134118.911396-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

iomap_write_begin() returns a folio based on current pos and
remaining length in the iter, and each caller then trims the
pos/length to the given folio. Clean this up a bit and let
iomap_write_begin() return the trimmed range along with the folio.

Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 92d7b659db33..233abf598f65 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -679,11 +679,12 @@ static int iomap_read_folio_sync(loff_t block_start, struct folio *folio,
 	return submit_bio_wait(&bio);
 }
 
-static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
-		size_t len, struct folio *folio)
+static int __iomap_write_begin(const struct iomap_iter *iter, size_t len,
+		struct folio *folio)
 {
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	struct iomap_folio_state *ifs;
+	loff_t pos = iter->pos;
 	loff_t block_size = i_blocksize(iter->inode);
 	loff_t block_start = round_down(pos, block_size);
 	loff_t block_end = round_up(pos + len, block_size);
@@ -794,15 +795,22 @@ static int iomap_write_begin_inline(const struct iomap_iter *iter,
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
 
+	len = min_not_zero(len, *plen);
 	BUG_ON(pos + len > iter->iomap.offset + iter->iomap.length);
 	if (srcmap != &iter->iomap)
 		BUG_ON(pos + len > srcmap->offset + srcmap->length);
@@ -834,20 +842,20 @@ static int iomap_write_begin(struct iomap_iter *iter, size_t len,
 		}
 	}
 
-	if (pos + len > folio_pos(folio) + folio_size(folio))
-		len = folio_pos(folio) + folio_size(folio) - pos;
+	pos = iomap_trim_folio_range(iter, folio, poffset, &len);
 
 	if (srcmap->type == IOMAP_INLINE)
 		status = iomap_write_begin_inline(iter, folio);
 	else if (srcmap->flags & IOMAP_F_BUFFER_HEAD)
 		status = __block_write_begin_int(folio, pos, len, NULL, srcmap);
 	else
-		status = __iomap_write_begin(iter, pos, len, folio);
+		status = __iomap_write_begin(iter, len, folio);
 
 	if (unlikely(status))
 		goto out_unlock;
 
 	*foliop = folio;
+	*plen = len;
 	return 0;
 
 out_unlock:
@@ -968,7 +976,7 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 			break;
 		}
 
-		status = iomap_write_begin(iter, bytes, &folio);
+		status = iomap_write_begin(iter, &folio, &offset, &bytes);
 		if (unlikely(status)) {
 			iomap_write_failed(iter->inode, iter->pos, bytes);
 			break;
@@ -976,7 +984,7 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 		if (iter->iomap.flags & IOMAP_F_STALE)
 			break;
 
-		pos = iomap_trim_folio_range(iter, folio, &offset, &bytes);
+		pos = iter->pos;
 
 		if (mapping_writably_mapped(mapping))
 			flush_dcache_folio(folio);
@@ -1296,14 +1304,12 @@ static int iomap_unshare_iter(struct iomap_iter *iter)
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
@@ -1368,7 +1374,7 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		bool ret;
 
 		bytes = min_t(u64, SIZE_MAX, bytes);
-		status = iomap_write_begin(iter, bytes, &folio);
+		status = iomap_write_begin(iter, &folio, &offset, &bytes);
 		if (status)
 			return status;
 		if (iter->iomap.flags & IOMAP_F_STALE)
@@ -1377,7 +1383,6 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		/* warn about zeroing folios beyond eof that won't write back */
 		WARN_ON_ONCE(folio_pos(folio) > iter->inode->i_size);
 
-		iomap_trim_folio_range(iter, folio, &offset, &bytes);
 		folio_zero_range(folio, offset, bytes);
 		folio_mark_accessed(folio);
 
-- 
2.49.0


