Return-Path: <linux-fsdevel+bounces-41214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 890C2A2C558
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 15:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DCEE167CC1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 14:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33AB240602;
	Fri,  7 Feb 2025 14:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FCEzHhvv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F8723F264
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Feb 2025 14:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738938640; cv=none; b=OwAhj7xEQbCrV3IrrckjlFNjOWSGBNc0P+RBd3u6rOX7HsmXaGasCoWjgv4PuFElLtzE+QeIZTcXNE0p4sDRqdW8WOcSkAYbMvcFD7Vy8Y74bkZQyKOEaMonA2ePFOZoD2ArQ42X5LmkzvPXxNzeJ5QvnnSM6QSqBfLSRn6+jhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738938640; c=relaxed/simple;
	bh=mQ6J+XrVw/Ql60WlleAzEGCzesGdBMZmpWeoDkQ50SA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s44mAlC1Pep11YpVClmp/+cRvc0GfVioh40yCBW9xElRSgap9U1RIzfPL4Rp7V2mYtnHWHaXIfgm5sQWFyg5VMJGClYA63RObFzGZpuTVIaL9/ZLhbR01RSR7QSRt9rqV2Veka+I5XJYtzpYbWgo15DKKo/CdYNqyCpfMqrkM/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FCEzHhvv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738938637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XknRkkqOU3DG0rBTSymEwhQI/my5TOTMyKCRtDTJReY=;
	b=FCEzHhvvwEglyUYXoqTpt3c2HVB2erdn6QF/lm/rBMNKAGH/C+KKA9GaRqN6Um7TSy0Axm
	mauCinvuy2RfzMo4jfH0qhrX1Vc0pa9ATi2pxSnRqkxYgnbUNvoSdL5M3U+mBUBe1fEEfE
	NMQUe+r33oCp8xC7CscKx1T7DaquDvM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2-OVSWfbp-NjCJw-QFqkowFQ-1; Fri,
 07 Feb 2025 09:30:34 -0500
X-MC-Unique: OVSWfbp-NjCJw-QFqkowFQ-1
X-Mimecast-MFC-AGG-ID: OVSWfbp-NjCJw-QFqkowFQ
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D0F2C180098B;
	Fri,  7 Feb 2025 14:30:33 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.48])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B3DF41800875;
	Fri,  7 Feb 2025 14:30:32 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v6 05/10] iomap: lift iter termination logic from iomap_iter_advance()
Date: Fri,  7 Feb 2025 09:32:48 -0500
Message-ID: <20250207143253.314068-6-bfoster@redhat.com>
In-Reply-To: <20250207143253.314068-1-bfoster@redhat.com>
References: <20250207143253.314068-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The iter termination logic in iomap_iter_advance() is only needed by
iomap_iter() to determine whether to proceed with the next mapping
for an ongoing operation. The old logic sets ret to 1 and then
terminates if the operation is complete (iter->len == 0) or the
previous iteration performed no work and the mapping has not been
marked stale. The stale check exists to allow operations to
retry the current mapping if an inconsistency has been detected.

To further genericize iomap_iter_advance(), lift the termination
logic into iomap_iter() and update the former to return success (0)
or an error code. iomap_iter() continues on successful advance and
non-zero iter->len or otherwise terminates in the no progress (and
not stale) or error cases.

Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/iter.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
index 1db16be7b9f0..8e0746ad80bd 100644
--- a/fs/iomap/iter.c
+++ b/fs/iomap/iter.c
@@ -27,17 +27,11 @@ static inline void iomap_iter_reset_iomap(struct iomap_iter *iter)
  */
 static inline int iomap_iter_advance(struct iomap_iter *iter, s64 count)
 {
-	bool stale = iter->iomap.flags & IOMAP_F_STALE;
-	int ret = 1;
-
 	if (WARN_ON_ONCE(count > iomap_length(iter)))
 		return -EIO;
 	iter->pos += count;
 	iter->len -= count;
-	if (!iter->len || (!count && !stale))
-		ret = 0;
-
-	return ret;
+	return 0;
 }
 
 static inline void iomap_iter_done(struct iomap_iter *iter)
@@ -69,6 +63,7 @@ static inline void iomap_iter_done(struct iomap_iter *iter)
  */
 int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 {
+	bool stale = iter->iomap.flags & IOMAP_F_STALE;
 	s64 processed;
 	int ret;
 
@@ -91,8 +86,18 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 		return processed;
 	}
 
-	/* advance and clear state from the previous iteration */
+	/*
+	 * Advance the iter and clear state from the previous iteration. Use
+	 * iter->len to determine whether to continue onto the next mapping.
+	 * Explicitly terminate in the case where the current iter has not
+	 * advanced at all (i.e. no work was done for some reason) unless the
+	 * mapping has been marked stale and needs to be reprocessed.
+	 */
 	ret = iomap_iter_advance(iter, processed);
+	if (!ret && iter->len > 0)
+		ret = 1;
+	if (ret > 0 && !iter->processed && !stale)
+		ret = 0;
 	iomap_iter_reset_iomap(iter);
 	if (ret <= 0)
 		return ret;
-- 
2.48.1


