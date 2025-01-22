Return-Path: <linux-fsdevel+bounces-39840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 536EAA192A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 14:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60AF4188202E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 13:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED91213E76;
	Wed, 22 Jan 2025 13:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FBTqh26u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F04213E61
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 13:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737552753; cv=none; b=XlNNMG8I4izxTUuS0KJxHPYOdciAKsUtSIqNyRf0d/ToTwRdAEm9+36WbGQscNx+TYwZrebHS6wEY4WJoiNkfjj6w48ttHxlN0YAPsDM7vVzP296hU6Gs1JCXw6iUJjlzjYbhUkUtA51Uz1KsHkhEvJllUeURtVXTrhWmVYC5+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737552753; c=relaxed/simple;
	bh=lwG2BDVsDqAqG9hTBHindPdECeSDnbfuTslTxwHs88g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gJZxoAWi+92QHlksZirbgCa5tkK7kDqJLtiEKzszXbMTfMzoGZRupB/SYDHGaHAtE44Sr8IR52z5GakwFzEPNQX/Xe81JSgh1D5oYVcI/31H4JHHIN1VQORN6YrWEjZ2p6+u9GxSLsXkQbCJiLOKhDBXEeigmC4KlIlWvSL3Gys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FBTqh26u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737552751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c8ow9AvUlMusll3m0l7rcYElRLAAREVFTuTJeL7Pt4g=;
	b=FBTqh26ue+X/YmgDZglfc4DBs9hrxPyenvYNaCUCnnNCJlB70fmV5n9qcNBbxdDCs6qFQg
	i4lt0iorCxtC1KEZU7IVU0Vkh/Vz6tSQF2ZjyVZv5pEgv6pa6v/pLYIK99K7BbVsUfyZ/4
	V+e631Dwwrp+NnsO0rMcHDS8gBaTVhA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-rgT2jz7fPu2AkEbIQa3fEg-1; Wed,
 22 Jan 2025 08:32:27 -0500
X-MC-Unique: rgT2jz7fPu2AkEbIQa3fEg-1
X-Mimecast-MFC-AGG-ID: rgT2jz7fPu2AkEbIQa3fEg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D05A819560BB;
	Wed, 22 Jan 2025 13:32:26 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.80.118])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1E65A19560A7;
	Wed, 22 Jan 2025 13:32:25 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org
Subject: [PATCH v2 7/7] iomap: advance the iter directly on zero range
Date: Wed, 22 Jan 2025 08:34:34 -0500
Message-ID: <20250122133434.535192-8-bfoster@redhat.com>
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

Modify zero range to advance the iter directly. Replace the local pos
and length calculations with direct advances and loop based on iter
state instead.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/iomap/buffered-io.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index ea140d3098ff..83ef6715a4b6 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1341,17 +1341,16 @@ static inline int iomap_zero_iter_flush_and_stale(struct iomap_iter *i)
 
 static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 {
-	loff_t pos = iter->pos;
-	loff_t length = iomap_length(iter);
-	loff_t written = 0;
+	size_t bytes = iomap_length(iter);
 
 	do {
 		struct folio *folio;
 		int status;
 		size_t offset;
-		size_t bytes = min_t(u64, SIZE_MAX, length);
+		loff_t pos = iter->pos;
 		bool ret;
 
+		bytes = min_t(u64, SIZE_MAX, bytes);
 		status = iomap_write_begin(iter, pos, bytes, &folio);
 		if (status)
 			return status;
@@ -1371,15 +1370,11 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		__iomap_put_folio(iter, pos, bytes, folio);
 		if (WARN_ON_ONCE(!ret))
 			return -EIO;
-
-		pos += bytes;
-		length -= bytes;
-		written += bytes;
-	} while (length > 0);
+	} while ((bytes = iomap_iter_advance(iter, bytes)) > 0);
 
 	if (did_zero)
 		*did_zero = true;
-	return written;
+	return bytes < 0 ? bytes : 0;
 }
 
 int
-- 
2.47.1


