Return-Path: <linux-fsdevel+bounces-37309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB359F0F40
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 15:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 441C1282812
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 14:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D001E1C26;
	Fri, 13 Dec 2024 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AL9LNKzp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AF61E0E10
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 14:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734100471; cv=none; b=t05RzaGqtTD83jnnrh3L16XgZ82DyCvNvBqU3Rd50hCVJEe8XMtPlzexRXlsQye4Q7NAtQ2DLntiEimqvHEbvqngRi5GLJBh32X5/UmR9Bt2/jrC49e6pxcMzsmTJey8m+CbkfWj95+2pRajJ5tNeLQ5AcoKxtCWkfhazIOiiSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734100471; c=relaxed/simple;
	bh=IYQ/xUS0lTvkHbAW76Lcj4NkZoF+W8014YmzTDWAKXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qSX0DaHYnzDbhaNNAIOdo5qmMEnLOurhN8HEZWSaeQafLheTwu8Q+xyq/P8e4KxwW5TLFc1hdSFI+GQ4F3iVg9tpQ284PHu8f0YeqqDkF2sORazEO/95637rKCTuPljubuJypQRbqHegCfbs9EJ3zuUI8AS+IrqMpMIDAZ3PyKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AL9LNKzp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734100468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s61qkuGL8kimAslrSvPqTtDGHX0G4zgPijrCuN+q7/U=;
	b=AL9LNKzp3JYDFuYzeE1bC0NZkLrgx8aT8AT9A5Tr8rO0mX+qg2Igi2xYxySRZCGy5RkaIS
	AoDm4OJhK6I5QOmN4GSBTRt6/2JOrSON6y5g3HbAgQ1+bsH3n2m4WKmfHfy3ROWIdJM9Hp
	EEUwMrPppKdNMoZxmyVu3o1LLXelNIQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-rSAcv_aWOBistHFqLnm7Wg-1; Fri,
 13 Dec 2024 09:34:26 -0500
X-MC-Unique: rSAcv_aWOBistHFqLnm7Wg-1
X-Mimecast-MFC-AGG-ID: rSAcv_aWOBistHFqLnm7Wg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 074E219560AB;
	Fri, 13 Dec 2024 14:34:26 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.90.12])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5EB4C195605A;
	Fri, 13 Dec 2024 14:34:25 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org
Subject: [PATCH 3/6] iomap: support incremental iomap_iter advances
Date: Fri, 13 Dec 2024 09:36:07 -0500
Message-ID: <20241213143610.1002526-4-bfoster@redhat.com>
In-Reply-To: <20241213143610.1002526-1-bfoster@redhat.com>
References: <20241213143610.1002526-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The current iomap_iter iteration model reads the mapping from the
filesystem, processes the subrange of the operation associated with
the current mapping, and returns the number of bytes processed back
to the iteration code. The latter advances the position and
remaining length of the iter in preparation for the next iteration.

At the _iter() handler level, this tends to produce a processing
loop where the local code pulls the current position and remaining
length out of the iter, iterates it locally based on file offset,
and then breaks out when the associated range has been fully
processed.

This works well enough for current handlers, but upcoming
enhancements require a bit more flexibility in certain situations.
Enhancements for zero range will lead to a situation where the
processing loop is no longer a pure ascending offset walk, but
rather dictated by pagecache state and folio lookup. Since folio
lookup and write preparation occur at different levels, it is more
difficult to manage position and length outside of the iter.

To provide more flexibility to certain iomap operations, introduce
support for incremental iomap_iter advances from within the
operation itself. This allows more granular advances for operations
that might not use the typical file offset based walk.

Note that the semantics for operations that use incremental advances
is slightly different than traditional operations. Operations that
advance the iter directly are expected to return success or failure
(i.e. 0 or negative error code) in iter.processed rather than the
number of bytes processed.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/iomap/iter.c       | 27 +++++++++++++++++++++------
 include/linux/iomap.h |  4 ++++
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
index 731ea7267f27..5fe0edb51fe5 100644
--- a/fs/iomap/iter.c
+++ b/fs/iomap/iter.c
@@ -25,7 +25,7 @@ static inline void iomap_iter_reset_iomap(struct iomap_iter *iter)
  * iterating" case needs to distinguish between (count = 0) meaning we are done
  * and (count = 0 && stale) meaning we need to remap the entire remaining range.
  */
-static inline int iomap_iter_advance(struct iomap_iter *iter, s64 count)
+int iomap_iter_advance(struct iomap_iter *iter, s64 count)
 {
 	bool stale = iter->iomap.flags & IOMAP_F_STALE;
 	int ret = 1;
@@ -36,7 +36,7 @@ static inline int iomap_iter_advance(struct iomap_iter *iter, s64 count)
 		return -EIO;
 	iter->pos += count;
 	iter->len -= count;
-	if (!iter->len || (!count && !stale))
+	if (!iter->len || (!count && !stale && iomap_length(iter)))
 		ret = 0;
 
 	return ret;
@@ -49,6 +49,8 @@ static inline void iomap_iter_done(struct iomap_iter *iter)
 	WARN_ON_ONCE(iter->iomap.offset + iter->iomap.length <= iter->pos);
 	WARN_ON_ONCE(iter->iomap.flags & IOMAP_F_STALE);
 
+	iter->iter_spos = iter->pos;
+
 	trace_iomap_iter_dstmap(iter->inode, &iter->iomap);
 	if (iter->srcmap.type != IOMAP_HOLE)
 		trace_iomap_iter_srcmap(iter->inode, &iter->srcmap);
@@ -74,10 +76,23 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 	int ret;
 
 	if (iter->iomap.length && ops->iomap_end) {
-		ret = ops->iomap_end(iter->inode, iter->pos, iomap_length(iter),
-				iter->processed > 0 ? iter->processed : 0,
-				iter->flags, &iter->iomap);
-		if (ret < 0 && !iter->processed)
+		ssize_t processed = iter->processed > 0 ? iter->processed : 0;
+		u64 olen = iter->len;
+
+		/*
+		 * If processed is zero, the op may have advanced the iter
+		 * itself. Update the processed and original length bytes based
+		 * on how far ->pos has advanced.
+		 */
+		if (!processed) {
+			processed = iter->pos - iter->iter_spos;
+			olen += processed;
+		}
+
+		ret = ops->iomap_end(iter->inode, iter->iter_spos,
+				__iomap_length(iter, iter->iter_spos, olen),
+				processed, iter->flags, &iter->iomap);
+		if (ret < 0 && !processed)
 			return ret;
 	}
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index cbacccb3fb14..704ed98159f7 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -211,6 +211,8 @@ struct iomap_ops {
  *	calls to iomap_iter().  Treat as read-only in the body.
  * @len: The remaining length of the file segment we're operating on.
  *	It is updated at the same time as @pos.
+ * @iter_spos: The original start pos for the current iomap. Used for
+ *	incremental iter advance.
  * @processed: The number of bytes processed by the body in the most recent
  *	iteration, or a negative errno. 0 causes the iteration to stop.
  * @flags: Zero or more of the iomap_begin flags above.
@@ -221,6 +223,7 @@ struct iomap_iter {
 	struct inode *inode;
 	loff_t pos;
 	u64 len;
+	loff_t iter_spos;
 	s64 processed;
 	unsigned flags;
 	struct iomap iomap;
@@ -229,6 +232,7 @@ struct iomap_iter {
 };
 
 int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops);
+int iomap_iter_advance(struct iomap_iter *iter, s64 count);
 
 /**
  * iomap_length - length of the current iomap iteration
-- 
2.47.0


