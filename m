Return-Path: <linux-fsdevel+bounces-39838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 438E9A1929E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 14:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F05D7A3CAF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 13:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033FE213E64;
	Wed, 22 Jan 2025 13:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PyXw+hWb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D5A2135C4
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 13:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737552751; cv=none; b=YF5PgSjplW4hBMgzpKo9mIty9mMWZyDVMa8DkgGWe/PvX3yKV6L6329zBHNiMGd2ghmFlmvv8tmAPvTEu9EiOvT8BJEtOyzACQv9v6L5TrYp5/O2ncNirRnm7LC96Ya4Jloe1/NO6EtI2Jj5V6yM6WcgQHfw6RVGWqfwZAz2h9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737552751; c=relaxed/simple;
	bh=z4IOxpwg7m38o5rBDHCM8b7YriJ5ilTeqiIsaX4pvzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jSRBHYdYPPru9GeQ25JJ/ErdiJFgZuccFz1b3WsS37I0J4dnTjLGo+Hy/bM0MaeS4yZ8/gNc4YIS15gmy2LJ6RMtiUqVLM2IDpKIOqpQuRfIxBFeeXc8sePMtKzEF7KXod4h5ti7gnTUCNCJ5gFiZ8R7XkAxPbGqrk5xT9L5xls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PyXw+hWb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737552748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6WKOAxT8IJe6f0d/3nAl0CkQjJPq7V0QFs8Ayh8xcUU=;
	b=PyXw+hWbfDgV45x2c5oRp7q2lAtzEpFfzVNCYuqLsZQKPgAGvrHL/iqBz1lDonFpKn5YDS
	x5P83COcGChYnVwOydbQ3jxginq8qbsVRhY6FJY+RO4s+ndob3fvRm4x2XeXqG/iY7WfHv
	Oq8f89VrObHJZkZ6+W09XiaFsmiJbfQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-lkIA_WbeMpesQ5MZ5VJB4w-1; Wed,
 22 Jan 2025 08:32:25 -0500
X-MC-Unique: lkIA_WbeMpesQ5MZ5VJB4w-1
X-Mimecast-MFC-AGG-ID: lkIA_WbeMpesQ5MZ5VJB4w
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 58FEE1955F2D;
	Wed, 22 Jan 2025 13:32:24 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.80.118])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CBE1A19560A7;
	Wed, 22 Jan 2025 13:32:23 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org
Subject: [PATCH v2 4/7] iomap: support incremental iomap_iter advances
Date: Wed, 22 Jan 2025 08:34:31 -0500
Message-ID: <20250122133434.535192-5-bfoster@redhat.com>
In-Reply-To: <20250122133434.535192-1-bfoster@redhat.com>
References: <20250122133434.535192-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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
 fs/iomap/iter.c       | 32 +++++++++++++++++++++++++-------
 include/linux/iomap.h |  3 +++
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
index 260ec702ddd5..191c54976c9f 100644
--- a/fs/iomap/iter.c
+++ b/fs/iomap/iter.c
@@ -37,6 +37,8 @@ static inline void iomap_iter_done(struct iomap_iter *iter)
 	WARN_ON_ONCE(iter->iomap.offset + iter->iomap.length <= iter->pos);
 	WARN_ON_ONCE(iter->iomap.flags & IOMAP_F_STALE);
 
+	iter->iter_start_pos = iter->pos;
+
 	trace_iomap_iter_dstmap(iter->inode, &iter->iomap);
 	if (iter->srcmap.type != IOMAP_HOLE)
 		trace_iomap_iter_srcmap(iter->inode, &iter->srcmap);
@@ -61,23 +63,39 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 {
 	s64 ret;
 	bool stale = iter->iomap.flags & IOMAP_F_STALE;
+	ssize_t advanced = iter->processed > 0 ? iter->processed : 0;
+	u64 olen = iter->len;
 
 	if (!iter->iomap.length) {
 		trace_iomap_iter(iter, ops, _RET_IP_);
 		goto begin;
 	}
 
+	/*
+	 * If iter.processed is zero, the op may still have advanced the iter
+	 * itself. Calculate the advanced and original length bytes based on how
+	 * far pos has advanced for ->iomap_end().
+	 */
+	if (!advanced) {
+		advanced = iter->pos - iter->iter_start_pos;
+		olen += advanced;
+	}
+
 	if (ops->iomap_end) {
-		ret = ops->iomap_end(iter->inode, iter->pos, iomap_length(iter),
-				iter->processed > 0 ? iter->processed : 0,
-				iter->flags, &iter->iomap);
-		if (ret < 0 && !iter->processed)
+		ret = ops->iomap_end(iter->inode, iter->iter_start_pos,
+				iomap_length_trim(iter, iter->iter_start_pos,
+						  olen),
+				advanced, iter->flags, &iter->iomap);
+		if (ret < 0 && !advanced)
 			return ret;
 	}
 
 	/*
-	 * Advance the iter and clear state from the previous iteration. The
-	 * remaining length of the previous iteration should be zero by this
+	 * Advance the iter and clear state from the previous iteration. This
+	 * passes iter->processed because that reflects the bytes processed but
+	 * not yet advanced by the iter handler.
+	 *
+	 * The remaining length of the previous iteration should be zero by this
 	 * point, so use iter->len to determine whether to continue onto the
 	 * next mapping. Explicitly terminate in the case where the current iter
 	 * has not advanced at all (i.e. no work was done for some reason)
@@ -87,7 +105,7 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 	ret = iomap_iter_advance(iter, iter->processed);
 	if (!ret)
 		ret = iter->len;
-	if (ret > 0 && !iter->processed && !stale)
+	if (ret > 0 && !advanced && !stale)
 		ret = 0;
 	iomap_iter_reset_iomap(iter);
 	if (ret <= 0)
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 88bde0259035..24fefc5fa868 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -211,6 +211,8 @@ struct iomap_ops {
  *	calls to iomap_iter().  Treat as read-only in the body.
  * @len: The remaining length of the file segment we're operating on.
  *	It is updated at the same time as @pos.
+ * @iter_start_pos: The original start pos for the current iomap. Used for
+ *	incremental iter advance.
  * @processed: The number of bytes processed by the body in the most recent
  *	iteration, or a negative errno. 0 causes the iteration to stop.
  * @flags: Zero or more of the iomap_begin flags above.
@@ -221,6 +223,7 @@ struct iomap_iter {
 	struct inode *inode;
 	loff_t pos;
 	u64 len;
+	loff_t iter_start_pos;
 	s64 processed;
 	unsigned flags;
 	struct iomap iomap;
-- 
2.47.1


