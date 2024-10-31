Return-Path: <linux-fsdevel+bounces-33352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 727B99B7C4C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 15:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00CB31F2208F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 14:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB6C1A00F2;
	Thu, 31 Oct 2024 14:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="efDndG6d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBE37483
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 14:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730383407; cv=none; b=CpIXFONRn7KM3LSF5bm6w2wSs/iSzdKLenpeRY01mCm+3T6+Z7rOFpT4zz5MuBaGr9KJyyV8VHotTadiOIAfnwDlxtqK8mWZoE/UGu3RL3PhuMoLOuorNDEWts7vsoJsQkBQIbwuacvpTPq9Dqg2AVZvHTjTUoq7EFUCFPZxywk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730383407; c=relaxed/simple;
	bh=qLK5Ffg4a5I0O0QOhfLfTRYU55Wu+75GcnEUd2pPqjE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ovZusdikCb694ObzlyxEgk7MaXSBqHeTZW+6g1r5Q/R8mqR/zmQuAv/ezFGFN8gEf6ztrdo/uKHx43lzV9adu4cbA7YdRQyWA6Uyw2YmYT1dYqADfZZeMAKQcp1cg6rruDhCAZuvjE0lUIowWspSN39s28KrON92qpb4US1Z67A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=efDndG6d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730383404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QCPHQ8RVrPVKBphVGcYz8qrNxmQafkpXvApU9MdgzUk=;
	b=efDndG6dlJtlcEf6+j8b1rXknf923d9/yeLmSF3Hx1fn/WV1VX7RQ1AlIiZv7QjvmP8p9s
	4vF/zB4KzhT7xR9mURGGdFwnwHQnUvmxTwEeKRM9VNRLfArUmF6CTWUO79lAoXSjMN+YYy
	IzTbJqtH70RBBYFZbHjekE1UvR+DKtQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-mNc3yRuWPnql7MN3PfEu6g-1; Thu,
 31 Oct 2024 10:03:23 -0400
X-MC-Unique: mNc3yRuWPnql7MN3PfEu6g-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E24F01955DAC
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 14:03:21 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.80.135])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6F4DC19560B2
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 14:03:21 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/2] iomap: lift zeroed mapping handling into iomap_zero_range()
Date: Thu, 31 Oct 2024 10:04:47 -0400
Message-ID: <20241031140449.439576-2-bfoster@redhat.com>
In-Reply-To: <20241031140449.439576-1-bfoster@redhat.com>
References: <20241031140449.439576-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

In preparation for special handling of subranges, lift the zeroed
mapping logic from the iterator into the caller. Since this puts the
pagecache dirty check and flushing in the same place, streamline the
comments a bit as well.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/iomap/buffered-io.c | 63 ++++++++++++++----------------------------
 1 file changed, 21 insertions(+), 42 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index aa587b2142e2..60386cb7b9ef 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1365,40 +1365,12 @@ static inline int iomap_zero_iter_flush_and_stale(struct iomap_iter *i)
 	return filemap_write_and_wait_range(mapping, i->pos, end);
 }
 
-static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero,
-		bool *range_dirty)
+static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 {
-	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	loff_t pos = iter->pos;
 	loff_t length = iomap_length(iter);
 	loff_t written = 0;
 
-	/*
-	 * We must zero subranges of unwritten mappings that might be dirty in
-	 * pagecache from previous writes. We only know whether the entire range
-	 * was clean or not, however, and dirty folios may have been written
-	 * back or reclaimed at any point after mapping lookup.
-	 *
-	 * The easiest way to deal with this is to flush pagecache to trigger
-	 * any pending unwritten conversions and then grab the updated extents
-	 * from the fs. The flush may change the current mapping, so mark it
-	 * stale for the iterator to remap it for the next pass to handle
-	 * properly.
-	 *
-	 * Note that holes are treated the same as unwritten because zero range
-	 * is (ab)used for partial folio zeroing in some cases. Hole backed
-	 * post-eof ranges can be dirtied via mapped write and the flush
-	 * triggers writeback time post-eof zeroing.
-	 */
-	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN) {
-		if (*range_dirty) {
-			*range_dirty = false;
-			return iomap_zero_iter_flush_and_stale(iter);
-		}
-		/* range is clean and already zeroed, nothing to do */
-		return length;
-	}
-
 	do {
 		struct folio *folio;
 		int status;
@@ -1448,24 +1420,31 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 	bool range_dirty;
 
 	/*
-	 * Zero range wants to skip pre-zeroed (i.e. unwritten) mappings, but
-	 * pagecache must be flushed to ensure stale data from previous
-	 * buffered writes is not exposed. A flush is only required for certain
-	 * types of mappings, but checking pagecache after mapping lookup is
-	 * racy with writeback and reclaim.
+	 * Zero range can skip mappings that are zero on disk so long as
+	 * pagecache is clean. If pagecache was dirty prior to zero range, the
+	 * mapping converts on writeback completion and must be zeroed.
 	 *
-	 * Therefore, check the entire range first and pass along whether any
-	 * part of it is dirty. If so and an underlying mapping warrants it,
-	 * flush the cache at that point. This trades off the occasional false
-	 * positive (and spurious flush, if the dirty data and mapping don't
-	 * happen to overlap) for simplicity in handling a relatively uncommon
-	 * situation.
+	 * The simplest way to deal with this is to flush pagecache and process
+	 * the updated mappings. To avoid an unconditional flush, check dirty
+	 * state and defer the flush until a combination of dirty pagecache and
+	 * at least one mapping that might convert on writeback is seen.
 	 */
 	range_dirty = filemap_range_needs_writeback(inode->i_mapping,
 					pos, pos + len - 1);
+	while ((ret = iomap_iter(&iter, ops)) > 0) {
+		const struct iomap *s = iomap_iter_srcmap(&iter);
+		if (s->type == IOMAP_HOLE || s->type == IOMAP_UNWRITTEN) {
+			loff_t p = iomap_length(&iter);
+			if (range_dirty) {
+				range_dirty = false;
+				p = iomap_zero_iter_flush_and_stale(&iter);
+			}
+			iter.processed = p;
+			continue;
+		}
 
-	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.processed = iomap_zero_iter(&iter, did_zero, &range_dirty);
+		iter.processed = iomap_zero_iter(&iter, did_zero);
+	}
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iomap_zero_range);
-- 
2.46.2


