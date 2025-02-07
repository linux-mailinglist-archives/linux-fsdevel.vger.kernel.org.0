Return-Path: <linux-fsdevel+bounces-41216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C67FAA2C55D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 15:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84D05167C49
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 14:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89457240612;
	Fri,  7 Feb 2025 14:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jcvaj4EV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6118C23F26E
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Feb 2025 14:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738938641; cv=none; b=MFiar1JPPdHiIC2OHZ3Tfingkxe1JzeKWUNVH+Jz0JpYGq16iImoOTNnc3OY5++YY3bOEEexO6lXO9JpB+UlcHlvQjArsbOpXLQVMwn8qkHr/l9Zu/Vq//+e6IkxUtPGBM5xPOsBXsDECFIP+xEtj2nwuXxB7HNSOL3pnZIwqLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738938641; c=relaxed/simple;
	bh=RdKSxLltcWrzc7ZuZGaWuOX0m0CHKAZEUFuJHzKp5TU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mh7M4j1QdKetrnvZg6b+YMEl+/TiKPBpwnMA1g4TvEXY8JQPNzzMbAgQscOhQS2FpjsvpWxJMmopiiUPcGCPVqoMi5LkLEPNq+CehhlhH9JP5HNyW1MTwn7YptSZhXLLjoUSr5gMf820rT2Jt1tcSnZXutQPFiwSfrXoilBl5wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jcvaj4EV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738938638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LIqOROp1h2jpAoG746CO9p8WPHzInrV6Tv2fPzR3/Jw=;
	b=Jcvaj4EVrvjZO+FHgZuEQYOrEvljQvD6vw+OPOH4q3LDTiegXpGYSgAM1sDbOEXwcCdXbZ
	FtyAGIZnrJHMtTWSZ0R9invTvYa/nR4ERIRynfSyj+FkXJDspHTfda+LtIlZpsVrrJVadk
	UUA0HLikjGJVNKI39lntmmzjB/p4oZo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205-xib2kJa1OCOIPoIo8WByuA-1; Fri,
 07 Feb 2025 09:30:36 -0500
X-MC-Unique: xib2kJa1OCOIPoIo8WByuA-1
X-Mimecast-MFC-AGG-ID: xib2kJa1OCOIPoIo8WByuA
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 08EC818011C7;
	Fri,  7 Feb 2025 14:30:35 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.48])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1F3E7180087C;
	Fri,  7 Feb 2025 14:30:33 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v6 06/10] iomap: export iomap_iter_advance() and return remaining length
Date: Fri,  7 Feb 2025 09:32:49 -0500
Message-ID: <20250207143253.314068-7-bfoster@redhat.com>
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

As a final step for generic iter advance, export the helper and
update it to return the remaining length of the current iteration
after the advance. This will usually be 0 in the iomap_iter() case,
but will be useful for the various operations that iterate on their
own and will be updated to advance as they progress.

Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/iter.c       | 22 ++++++++--------------
 include/linux/iomap.h |  1 +
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
index 8e0746ad80bd..544cd7a5a16b 100644
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
+ * Advance the current iterator position and output the length remaining for the
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
 
@@ -93,7 +87,7 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 	 * advanced at all (i.e. no work was done for some reason) unless the
 	 * mapping has been marked stale and needs to be reprocessed.
 	 */
-	ret = iomap_iter_advance(iter, processed);
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


