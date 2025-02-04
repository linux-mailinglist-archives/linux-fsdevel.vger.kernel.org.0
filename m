Return-Path: <linux-fsdevel+bounces-40749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEC7A2734C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 14:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28FDE168792
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 13:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70459213227;
	Tue,  4 Feb 2025 13:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aJ0eTdk/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C08C215F63
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 13:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738675706; cv=none; b=NX/Kb4N0k6qP4p5umh9RML1ittMX/msuKOEzvzsUSLxNUhj4uluJ0ZgFY/PX36haGt/bM+gyOD6Pj5D/9oIdhDtxMHiAKn5GMywh62nXqsN60TApIZj1Uh/xeYuovvsRxROjSmSfa+lK8SugZ8nZ7kE5VZr9L3sXlFeZgRBcMAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738675706; c=relaxed/simple;
	bh=dXen0DTYAlGNQYYaDMnjO2sZtIbbtkxy0gZwBzm+jZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g6bmdJrXxj6TvMHlU8CwmbfOME0GSHl6rSiL6cYX08pP/aaV1ju0IQqMdCjVV8TH8c1lgZ+sMzta7/ppFAl/Txp3hGRP0h9VhKoT2AGYf47YYAl0oEtImN0JpfsjrE9zfjjmP1Z4vnLgb8tHkP9NW5q3Y3enTtK6kjzlVasuSzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aJ0eTdk/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738675704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TRZyPJSOIJqRx4T6prfBGyNdUHyxuHREUAR+mm6vxL8=;
	b=aJ0eTdk/wVmUHAu7w6CNt8qCBqrqkKybjdph0OUZRJIuhtbin5dbGtwvZeP9fegAZHaaIp
	Zqs2b0hNEyytOOZmXZI+i0P7plmztSSWxi2IOMjWjPbkhLKzohgUX+DlL3a7h8nO2FTLSE
	iyn4fP23b7wsenxgsiUhIQb2HdQcPNI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146-5YoVZ6k_M7y0JmTtqX9dUw-1; Tue,
 04 Feb 2025 08:28:21 -0500
X-MC-Unique: 5YoVZ6k_M7y0JmTtqX9dUw-1
X-Mimecast-MFC-AGG-ID: 5YoVZ6k_M7y0JmTtqX9dUw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0A27F1801F0E;
	Tue,  4 Feb 2025 13:28:20 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.48])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 16C3719560AD;
	Tue,  4 Feb 2025 13:28:18 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v4 01/10] iomap: factor out iomap length helper
Date: Tue,  4 Feb 2025 08:30:35 -0500
Message-ID: <20250204133044.80551-2-bfoster@redhat.com>
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

In preparation to support more granular iomap iter advancing, factor
the pos/len values as parameters to length calculation.

Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/iomap.h | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 75bf54e76f3b..f5ca71ac2fa2 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -231,18 +231,33 @@ struct iomap_iter {
 int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops);
 
 /**
- * iomap_length - length of the current iomap iteration
+ * iomap_length_trim - trimmed length of the current iomap iteration
  * @iter: iteration structure
+ * @pos: File position to trim from.
+ * @len: Length of the mapping to trim to.
  *
- * Returns the length that the operation applies to for the current iteration.
+ * Returns a trimmed length that the operation applies to for the current
+ * iteration.
  */
-static inline u64 iomap_length(const struct iomap_iter *iter)
+static inline u64 iomap_length_trim(const struct iomap_iter *iter, loff_t pos,
+		u64 len)
 {
 	u64 end = iter->iomap.offset + iter->iomap.length;
 
 	if (iter->srcmap.type != IOMAP_HOLE)
 		end = min(end, iter->srcmap.offset + iter->srcmap.length);
-	return min(iter->len, end - iter->pos);
+	return min(len, end - pos);
+}
+
+/**
+ * iomap_length - length of the current iomap iteration
+ * @iter: iteration structure
+ *
+ * Returns the length that the operation applies to for the current iteration.
+ */
+static inline u64 iomap_length(const struct iomap_iter *iter)
+{
+	return iomap_length_trim(iter, iter->pos, iter->len);
 }
 
 /**
-- 
2.48.1


