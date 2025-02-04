Return-Path: <linux-fsdevel+bounces-40754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F15FA27359
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 14:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0BB53A1285
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 13:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4B621CA11;
	Tue,  4 Feb 2025 13:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SqlWBJEd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389A621C9EA
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 13:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738675712; cv=none; b=pt2VRkYHTsk1R1IUDyBvny/4aqES80Av4isA2Ei9wp+NUQH0JG9s/NcDPIJBkmnLFBesnJT2Z3q+jGHw51vIiJhil7sMA8MVFuP0D/8iWa6cCVnL2HyaRjE7yGgPhq7r3ywVj7Y0CKR5dImlnDdsU6o1nYG+DTL6wNZlSicLt9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738675712; c=relaxed/simple;
	bh=Yc9TTqyo+jDCtcqvDfTS58eTbZd/3EBQyjRv5dBaQC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OGrmDr46frauMGd79xv1GlQFVAoCZwW45Sc8A+xvQLcy8QaSLD95Pr5JrgSvwI34gfAGBS4JgmPo8UgTSJQ8TaAErZm63dNb4pkKCHX3htI2LutP++0XWrLjzYZkAiZA27l7z9YyAqlrKtwzsqnxO3dhA68zX+czLxG03t7MKJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SqlWBJEd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738675710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IU7q976fyuBj7GHUX2ToD/kdh2ZVN0Ii3+LBln9mc5c=;
	b=SqlWBJEdX2iyKGuqBDGcnX/CL8a5MnDw32kLi4YwrngSzwgSyxR+C3V8TZc40XPrfmRYnl
	vC9jKr5uPrzlsSaD3Kc0wyJ/a/7nhMq+bMoq6CWZFt0dAB8zM2pPmSZ39nQW5/txhmzonI
	Jad4JuLjoqmF9cj4n0r7d4XcnPEXNWU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-347-nyjrG5rMNgye8fxPgjElAQ-1; Tue,
 04 Feb 2025 08:28:27 -0500
X-MC-Unique: nyjrG5rMNgye8fxPgjElAQ-1
X-Mimecast-MFC-AGG-ID: nyjrG5rMNgye8fxPgjElAQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D1A5C19560B4;
	Tue,  4 Feb 2025 13:28:25 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.48])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B7FE519560AD;
	Tue,  4 Feb 2025 13:28:24 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v4 06/10] iomap: export iomap_iter_advance() and return remaining length
Date: Tue,  4 Feb 2025 08:30:40 -0500
Message-ID: <20250204133044.80551-7-bfoster@redhat.com>
In-Reply-To: <20250204133044.80551-1-bfoster@redhat.com>
References: <20250204133044.80551-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

As a final step for generic iter advance, export the helper and
update it to return the remaining length of the current iteration
after the advance. This will usually be 0 in the iomap_iter() case,
but will be useful for the various operations that iterate on their
own and will be updated to advance as they progress.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/iomap/iter.c       | 28 ++++++++++++----------------
 include/linux/iomap.h |  1 +
 2 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
index 04bd39ee5d47..cdba24dbbfd7 100644
--- a/fs/iomap/iter.c
+++ b/fs/iomap/iter.c
@@ -15,22 +15,16 @@ static inline void iomap_iter_reset_iomap(struct iomap_iter *iter)
 }
 
 /*
- * Advance to the next range we need to map.
- *
- * If the iomap is marked IOMAP_F_STALE, it means the existing map was not fully
- * processed - it was aborted because the extent the iomap spanned may have been
- * changed during the operation. In this case, the iteration behaviour is to
- * remap the unprocessed range of the iter, and that means we may need to remap
- * even when we've made no progress (i.e. count = 0). Hence the "finished
- * iterating" case needs to distinguish between (count = 0) meaning we are done
- * and (count = 0 && stale) meaning we need to remap the entire remaining range.
+ * Advance the current iterator position and return the length remaining for the
+ * current mapping.
  */
-static inline int iomap_iter_advance(struct iomap_iter *iter, s64 count)
+int iomap_iter_advance(struct iomap_iter *iter, u64 *count)
 {
-	if (WARN_ON_ONCE(count > iomap_length(iter)))
+	if (WARN_ON_ONCE(*count > iomap_length(iter)))
 		return -EIO;
-	iter->pos += count;
-	iter->len -= count;
+	iter->pos += *count;
+	iter->len -= *count;
+	*count = iomap_length(iter);
 	return 0;
 }
 
@@ -64,6 +58,7 @@ static inline void iomap_iter_done(struct iomap_iter *iter)
 int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 {
 	bool stale = iter->iomap.flags & IOMAP_F_STALE;
+	s64 processed;
 	int ret;
 
 	trace_iomap_iter(iter, ops, _RET_IP_);
@@ -79,9 +74,10 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 			return ret;
 	}
 
-	if (iter->processed < 0) {
+	processed = iter->processed;
+	if (processed < 0) {
 		iomap_iter_reset_iomap(iter);
-		return iter->processed;
+		return processed;
 	}
 
 	/*
@@ -91,7 +87,7 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 	 * advanced at all (i.e. no work was done for some reason) unless the
 	 * mapping has been marked stale and needs to be reprocessed.
 	 */
-	ret = iomap_iter_advance(iter, iter->processed);
+	ret = iomap_iter_advance(iter, &processed);
 	if (!ret && iter->len > 0)
 		ret = 1;
 	if (ret > 0 && !iter->processed && !stale)
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index f5ca71ac2fa2..f304c602e5fe 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -229,6 +229,7 @@ struct iomap_iter {
 };
 
 int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops);
+int iomap_iter_advance(struct iomap_iter *iter, u64 *count);
 
 /**
  * iomap_length_trim - trimmed length of the current iomap iteration
-- 
2.48.1


