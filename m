Return-Path: <linux-fsdevel+bounces-48251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6542FAAC6B6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 15:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE2F54A1EA4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 13:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12282820A4;
	Tue,  6 May 2025 13:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X8Vave6C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0E9281528
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 May 2025 13:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746538698; cv=none; b=gbCRWkb+qzHt9B7w4Ke74uOkYvZBT6orL2ufbcE2q0vR4dutJbvvYHJW44y3+xSnn3unrMpUmc0/DmFISaKfVLB7pPNomFa0sbqnJqpQqJ0XgiaMC7rEIjcDga0GnEi3rTZzK6BZQPaXYOeqJACl8FDWPp4jwcdsniRRuxpXvwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746538698; c=relaxed/simple;
	bh=N3jf+x7YIHEpu+iezzMHG0wvDE97TSJoTshtaNBjRu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g9K9xyH7oAu+HY3vewdCDVHIORq1pZ/2aaMgK7hpXFK/fhMVD33cteZXTXXKQFQ/aGayB1FfS6tr4+7ek803xi46Mmvg1xFwHMtmJ584Fl0/sfgvxQ57C1QdNnpjOwU6zW7c4YVvhCAZYAX+LmW4VSENabKAg34uOqX2Brf8x/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X8Vave6C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746538694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cG4Njz9QU/5Qa09BhieVaQE4EqIBEoMIfRF6PM6Urow=;
	b=X8Vave6CMnXlGjc3+BoGhGbM/HbEMKK6+X1VOqgTdhOpKOqM75RO2OxLHAVcIjfCb3WYdR
	u5TuuDFbNCTZUxEM/sTPmWhIcdryrQcPltRZoLTPYnuo6KTBoDgCgp4qYab15y40qRc7if
	+zd/Zx/KMWjiHXyAn4XUQkGwi1/NQAk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-u0XCw2SEMhqfMnRn2QiltQ-1; Tue,
 06 May 2025 09:38:12 -0400
X-MC-Unique: u0XCw2SEMhqfMnRn2QiltQ-1
X-Mimecast-MFC-AGG-ID: u0XCw2SEMhqfMnRn2QiltQ_1746538691
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A56B41955DDF;
	Tue,  6 May 2025 13:38:11 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.64.112])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B7EFB19560A3;
	Tue,  6 May 2025 13:38:10 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	djwong@kernel.org,
	hch@infradead.org
Subject: [PATCH v2 4/6] iomap: helper to trim pos/bytes to within folio
Date: Tue,  6 May 2025 09:41:16 -0400
Message-ID: <20250506134118.911396-5-bfoster@redhat.com>
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

Several buffered write based iteration callbacks duplicate logic to
trim the current pos and length to within the current folio. Factor
this into a helper to make it easier to relocate closer to folio
lookup.

Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 5c08b2916bc7..11046a3c60fe 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -766,6 +766,22 @@ static void __iomap_put_folio(struct iomap_iter *iter, size_t ret,
 	}
 }
 
+/* trim pos and bytes to within a given folio */
+static loff_t iomap_trim_folio_range(struct iomap_iter *iter,
+		struct folio *folio, size_t *offset, u64 *bytes)
+{
+	loff_t pos = iter->pos;
+	size_t fsize = folio_size(folio);
+
+	WARN_ON_ONCE(pos < folio_pos(folio));
+	WARN_ON_ONCE(pos >= folio_pos(folio) + fsize);
+
+	*offset = offset_in_folio(folio, pos);
+	*bytes = min(*bytes, fsize - *offset);
+
+	return pos;
+}
+
 static int iomap_write_begin_inline(const struct iomap_iter *iter,
 		struct folio *folio)
 {
@@ -920,7 +936,7 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 		struct folio *folio;
 		loff_t old_size;
 		size_t offset;		/* Offset into folio */
-		size_t bytes;		/* Bytes to write to folio */
+		u64 bytes;		/* Bytes to write to folio */
 		size_t copied;		/* Bytes copied from user */
 		u64 written;		/* Bytes have been written */
 		loff_t pos;
@@ -959,11 +975,8 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 		}
 		if (iter->iomap.flags & IOMAP_F_STALE)
 			break;
-		pos = iter->pos;
 
-		offset = offset_in_folio(folio, pos);
-		if (bytes > folio_size(folio) - offset)
-			bytes = folio_size(folio) - offset;
+		pos = iomap_trim_folio_range(iter, folio, &offset, &bytes);
 
 		if (mapping_writably_mapped(mapping))
 			flush_dcache_folio(folio);
@@ -1280,7 +1293,6 @@ static int iomap_unshare_iter(struct iomap_iter *iter)
 	do {
 		struct folio *folio;
 		size_t offset;
-		loff_t pos;
 		bool ret;
 
 		bytes = min_t(u64, SIZE_MAX, bytes);
@@ -1289,11 +1301,8 @@ static int iomap_unshare_iter(struct iomap_iter *iter)
 			return status;
 		if (iomap->flags & IOMAP_F_STALE)
 			break;
-		pos = iter->pos;
 
-		offset = offset_in_folio(folio, pos);
-		if (bytes > folio_size(folio) - offset)
-			bytes = folio_size(folio) - offset;
+		iomap_trim_folio_range(iter, folio, &offset, &bytes);
 
 		ret = iomap_write_end(iter, bytes, bytes, folio);
 		__iomap_put_folio(iter, bytes, folio);
@@ -1356,7 +1365,6 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 	do {
 		struct folio *folio;
 		size_t offset;
-		loff_t pos;
 		bool ret;
 
 		bytes = min_t(u64, SIZE_MAX, bytes);
@@ -1365,14 +1373,11 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 			return status;
 		if (iter->iomap.flags & IOMAP_F_STALE)
 			break;
-		pos = iter->pos;
 
 		/* warn about zeroing folios beyond eof that won't write back */
 		WARN_ON_ONCE(folio_pos(folio) > iter->inode->i_size);
-		offset = offset_in_folio(folio, pos);
-		if (bytes > folio_size(folio) - offset)
-			bytes = folio_size(folio) - offset;
 
+		iomap_trim_folio_range(iter, folio, &offset, &bytes);
 		folio_zero_range(folio, offset, bytes);
 		folio_mark_accessed(folio);
 
-- 
2.49.0


