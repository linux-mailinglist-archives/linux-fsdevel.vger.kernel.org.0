Return-Path: <linux-fsdevel+bounces-34013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A97339C1D2D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 13:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23EE61C22D33
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 12:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FB41E9098;
	Fri,  8 Nov 2024 12:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G9CbFHiG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2CF1E9062
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 12:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731069678; cv=none; b=A0sAvqfDZsahTs8rvhA3Dg/M0jawxLYU2ebVVG3m03yX8s6Sep+UJhj48oHu5tWnZPYQ9VoGb2COfv744+W1HkeYsYAZl99IiLZtyItA/7iQ5l0q0LqekKx/RJHLbzhaPV2e7kkIXAOBIhI2gb9Yq3i2nA+JZhJ5EWfDYCiPV88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731069678; c=relaxed/simple;
	bh=MsqC22c04jXtwtqRCrwRMUrOe0DXV36idPQO4W8RiVU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sz6quC/w/WepxK60QhZP6vAw2BB1y0POHEmglEXwNVQnF/lzlZQgJW1bd3JjvWNfyTQsau/SfvrEVaDFmt+UAn9JjSagmiCu3UPF8Pu5gdAClM0eVb1CZrlpxbNkRGOD4lTUg1H8Ax4Ja5RRnnAasqwlZd8O9a/EUUuwT1EDnvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G9CbFHiG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731069676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=usUcH3wz/HjPZAnLZ2ldoPzaSqZUJUZ/Tb70MMky47Q=;
	b=G9CbFHiG8GoX7CY4fAseKjo8vzKYdrqQ4ogea0OBIsIwDCjuENITqwrpj6lWxzsiSVnQGM
	S4Qyst23tXswzw6SNcPW832W/xvrXwBssDYgIZHAcclJKqhxFDg7AgP+lvmP0UV6fI70dE
	qqXBe3C1cqfTW4Yl0cg3+4OAdLRvEw4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-324-sYvy6H2oO6SYGnN7RSQJ9g-1; Fri,
 08 Nov 2024 07:41:14 -0500
X-MC-Unique: sYvy6H2oO6SYGnN7RSQJ9g-1
X-Mimecast-MFC-AGG-ID: sYvy6H2oO6SYGnN7RSQJ9g
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D679F19560AF
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 12:41:13 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.64.111])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5EAF51956054
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 12:41:13 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 2/4] iomap: lift zeroed mapping handling into iomap_zero_range()
Date: Fri,  8 Nov 2024 07:42:44 -0500
Message-ID: <20241108124246.198489-3-bfoster@redhat.com>
In-Reply-To: <20241108124246.198489-1-bfoster@redhat.com>
References: <20241108124246.198489-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

In preparation for special handling of subranges, lift the zeroed
mapping logic from the iterator into the caller. Since this puts the
pagecache dirty check and flushing in the same place, streamline the
comments a bit as well.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/iomap/buffered-io.c | 64 +++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 42 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index ef0b68bccbb6..a78b5b9b3df3 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1350,40 +1350,12 @@ static inline int iomap_zero_iter_flush_and_stale(struct iomap_iter *i)
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
@@ -1433,24 +1405,32 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 	bool range_dirty;
 
 	/*
-	 * Zero range wants to skip pre-zeroed (i.e. unwritten) mappings, but
-	 * pagecache must be flushed to ensure stale data from previous
-	 * buffered writes is not exposed. A flush is only required for certain
-	 * types of mappings, but checking pagecache after mapping lookup is
-	 * racy with writeback and reclaim.
+	 * Zero range can skip mappings that are zero on disk so long as
+	 * pagecache is clean. If pagecache was dirty prior to zero range, the
+	 * mapping converts on writeback completion and so must be zeroed.
 	 *
-	 * Therefore, check the entire range first and pass along whether any
-	 * part of it is dirty. If so and an underlying mapping warrants it,
-	 * flush the cache at that point. This trades off the occasional false
-	 * positive (and spurious flush, if the dirty data and mapping don't
-	 * happen to overlap) for simplicity in handling a relatively uncommon
-	 * situation.
+	 * The simplest way to deal with this across a range is to flush
+	 * pagecache and process the updated mappings. To avoid an unconditional
+	 * flush, check pagecache state and only flush if dirty and the fs
+	 * returns a mapping that might convert on writeback.
 	 */
 	range_dirty = filemap_range_needs_writeback(inode->i_mapping,
 					pos, pos + len - 1);
+	while ((ret = iomap_iter(&iter, ops)) > 0) {
+		const struct iomap *s = iomap_iter_srcmap(&iter);
+
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
2.47.0


