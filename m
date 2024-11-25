Return-Path: <linux-fsdevel+bounces-35796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2D39D874C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 15:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EA6E2864CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 14:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392791AF0D1;
	Mon, 25 Nov 2024 14:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PoxT73yp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0A61AF0C7
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 14:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732543483; cv=none; b=QaFTadKJcrcowUqcBtN/zITuroNIkEktWtl/cNJP1SBnTquH6tlgbL9virpXAC99v3tDJVWR6keEefUjqXNqOrZy3eN0u/1MO0oEWRY6hB4/RHUeBhUk2W4JdnKNSRuu8QYQETbhI2ne7u2LNIvl40T2W+EQ06CdJ0iszX7KEGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732543483; c=relaxed/simple;
	bh=YtM653ja4KUJmPyqWieTI+e2Je9wpFU2u4c+8e45u2Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BxJOkVnzILBRSMOIQK49DPiLy5beS3R04+I9yLT80yyglultwNIMtj/FQfHO472u5nZd+Xz99yOSLWtkFql+avViqIKy94jp3qgLuCkyWzFHyMGdAcRQMsOdUVYOojhWdnHgNmMd4Ysn6HBRmEBPQuP6yEZ6cz2U9zH9iCaVf8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PoxT73yp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732543480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6tH1NIzGo3EjoOVDhcrarKwMnaI4mL7jdvGCeNFaTCg=;
	b=PoxT73yptcri35X+x04XYJpEFEdvbv4SauJMe5nYkagW+uGiK/TINkLVjkzbDy4a50apPK
	9aihD3Hs7XN1gpTk9xfZTsL4ce7Y3eZbfUUK02kYKse4wW7PgZHOEOWJ9EuUfqoIfWATE8
	eWMVrFoEgxQjv4x6jGVv2DOz7FxWh70=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-u6ElZTtNN3qHMhdUunii-g-1; Mon,
 25 Nov 2024 09:04:39 -0500
X-MC-Unique: u6ElZTtNN3qHMhdUunii-g-1
X-Mimecast-MFC-AGG-ID: u6ElZTtNN3qHMhdUunii-g
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 73FA919560AB
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 14:04:38 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.80.8])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0073D1956086
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 14:04:37 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC] iomap: more granular iteration
Date: Mon, 25 Nov 2024 09:06:23 -0500
Message-ID: <20241125140623.20633-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Not-Signed-off-by: Brian Foster <bfoster@redhat.com>
---

Hi all,

I just wanted to throw this against the wall for early
thoughts/feedback. This relates to to the iomap folio batch support
series, in particular pushing the batch handling code further down into
the normal get folio path.

Firstly for reference, this RFC is a squash of several logical changes
that should be separate patches:

1. Split off state clearing from iomap_advance_iter() into a separate
helper.
2. Add an iter_len field to iomap_iter to track per-iteration length.
3. Update iomap_zero_iter() to use granular iteration instead of local
variables for pos/len.

The objective is I'm looking for a cleaner way to support a sparse range
(based on a set of folios in a batch) beyond just turning pos/len into
pointers. Most of the iomap iterators duplicate a lot of boilerplate
around copying pos/len out of the iter, processing it locally in a loop
based on length, and then passing state back into the iter via
iter->processed.

The idea here is to replace some of that with more granular iter state
so the iteratora function can advance the iter on its own. In turn, this
facilitates the ability of the write_begin() path to advance the
iterator based on batched folio lookup if the folio set happens to be
logically discontiguous.

I still need to push some of the length/bytes chunking stuff further
down closer to get_folio before this is possible, but the hope is we can
end up with something like the following at the iterator level:

	do {
		/* iter->pos/iter_len advanced based on folio pos */
		status = iomap_write_begin(iter, &folio);

		... calc/process folio_[offset|bytes] ...

		iomap_advance_iter(iter, folio_bytes);
	} while (iter->iter_len > 0);
	...
	return 0;

The one warty thing I have so far is marking the iomap stale on iter_len
consumption to allow these types of iterators to return error/success
(i.e. return 0 instead of a written count) without the higher level
advance causing a loop termination. This could probably be done
differently, but this should be a no-op for non-granular iterators so
I'm not that worried about it as of yet.

Thoughts/comments on any of this appreciated. Thanks.

Brian

 fs/iomap/buffered-io.c | 22 ++++++++-------------
 fs/iomap/iter.c        | 45 +++++++++++++++++++++++++++++++-----------
 include/linux/iomap.h  |  2 ++
 3 files changed, 43 insertions(+), 26 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 0708be776740..c479ec73dedd 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1352,18 +1352,14 @@ static inline int iomap_zero_iter_flush_and_stale(struct iomap_iter *i)
 
 static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 {
-	loff_t pos = iter->pos;
-	loff_t length = iomap_length(iter);
-	loff_t written = 0;
-
 	do {
 		struct folio *folio;
 		int status;
 		size_t offset;
-		size_t bytes = min_t(u64, SIZE_MAX, length);
+		size_t bytes = min_t(u64, SIZE_MAX, iter->iter_len);
 		bool ret;
 
-		status = iomap_write_begin(iter, pos, bytes, &folio);
+		status = iomap_write_begin(iter, iter->pos, bytes, &folio);
 		if (status)
 			return status;
 		if (iter->iomap.flags & IOMAP_F_STALE)
@@ -1371,26 +1367,24 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 
 		/* warn about zeroing folios beyond eof that won't write back */
 		WARN_ON_ONCE(folio_pos(folio) > iter->inode->i_size);
-		offset = offset_in_folio(folio, pos);
+		offset = offset_in_folio(folio, iter->pos);
 		if (bytes > folio_size(folio) - offset)
 			bytes = folio_size(folio) - offset;
 
 		folio_zero_range(folio, offset, bytes);
 		folio_mark_accessed(folio);
 
-		ret = iomap_write_end(iter, pos, bytes, bytes, folio);
-		__iomap_put_folio(iter, pos, bytes, folio);
+		ret = iomap_write_end(iter, iter->pos, bytes, bytes, folio);
+		__iomap_put_folio(iter, iter->pos, bytes, folio);
 		if (WARN_ON_ONCE(!ret))
 			return -EIO;
 
-		pos += bytes;
-		length -= bytes;
-		written += bytes;
-	} while (length > 0);
+		iomap_iter_advance(iter, bytes);
+	} while (iter->iter_len > 0);
 
 	if (did_zero)
 		*did_zero = true;
-	return written;
+	return 0;
 }
 
 int
diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
index 3790918646af..962f4b35d856 100644
--- a/fs/iomap/iter.c
+++ b/fs/iomap/iter.c
@@ -7,6 +7,14 @@
 #include <linux/iomap.h>
 #include "trace.h"
 
+/* clear out iomaps from the fs */
+static inline void iomap_iter_reset_iomap(struct iomap_iter *iter)
+{
+	iter->processed = iter->iter_len = 0;
+	memset(&iter->iomap, 0, sizeof(iter->iomap));
+	memset(&iter->srcmap, 0, sizeof(iter->srcmap));
+}
+
 /*
  * Advance to the next range we need to map.
  *
@@ -19,30 +27,40 @@
  * (processed = 0) meaning we are done and (processed = 0 && stale) meaning we
  * need to remap the entire remaining range.
  */
-static inline int iomap_iter_advance(struct iomap_iter *iter)
+int iomap_iter_advance(struct iomap_iter *iter, s64 count)
 {
 	bool stale = iter->iomap.flags & IOMAP_F_STALE;
 	int ret = 1;
 
 	/* handle the previous iteration (if any) */
 	if (iter->iomap.length) {
-		if (iter->processed < 0)
-			return iter->processed;
-		if (WARN_ON_ONCE(iter->processed > iomap_length(iter)))
+		if (count < 0)
+			return count;
+		if (WARN_ON_ONCE(count > iter->iter_len))
 			return -EIO;
-		iter->pos += iter->processed;
-		iter->len -= iter->processed;
-		if (!iter->len || (!iter->processed && !stale))
+		iter->pos += count;
+		iter->len -= count;
+		if (!iter->len || (!count && !stale))
 			ret = 0;
+		iter->iter_len -= count;
+		/*
+		 * XXX: Stale the mapping on consuming iter_len to prevent
+		 * interference from subsequent 0 byte (i.e. return success
+		 * advance). Perhaps use a separate flag here for "incremental"
+		 * iterators..?
+		 */
+		if (!iter->iter_len)
+			iter->iomap.flags |= IOMAP_F_STALE;
 	}
 
-	/* clear the per iteration state */
-	iter->processed = 0;
-	memset(&iter->iomap, 0, sizeof(iter->iomap));
-	memset(&iter->srcmap, 0, sizeof(iter->srcmap));
 	return ret;
 }
 
+static inline int iomap_iter_advance_processed(struct iomap_iter *iter)
+{
+	return iomap_iter_advance(iter, iter->processed);
+}
+
 static inline void iomap_iter_done(struct iomap_iter *iter)
 {
 	WARN_ON_ONCE(iter->iomap.offset > iter->pos);
@@ -53,6 +71,8 @@ static inline void iomap_iter_done(struct iomap_iter *iter)
 	trace_iomap_iter_dstmap(iter->inode, &iter->iomap);
 	if (iter->srcmap.type != IOMAP_HOLE)
 		trace_iomap_iter_srcmap(iter->inode, &iter->srcmap);
+
+	iter->iter_len = iomap_length(iter);
 }
 
 /**
@@ -83,7 +103,8 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 	}
 
 	trace_iomap_iter(iter, ops, _RET_IP_);
-	ret = iomap_iter_advance(iter);
+	ret = iomap_iter_advance_processed(iter);
+	iomap_iter_reset_iomap(iter);
 	if (ret <= 0)
 		return ret;
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 27048ec10e1c..6fb7adc1f2c6 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -217,6 +217,7 @@ struct iomap_iter {
 	struct inode *inode;
 	loff_t pos;
 	u64 len;
+	u64 iter_len;
 	s64 processed;
 	unsigned flags;
 	struct iomap iomap;
@@ -225,6 +226,7 @@ struct iomap_iter {
 };
 
 int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops);
+int iomap_iter_advance(struct iomap_iter *iter, s64 count);
 
 /**
  * iomap_length - length of the current iomap iteration
-- 
2.47.0


