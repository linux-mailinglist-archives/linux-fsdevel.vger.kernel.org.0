Return-Path: <linux-fsdevel+bounces-39839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75075A1929C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 14:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30CE9166A86
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 13:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40820213E6C;
	Wed, 22 Jan 2025 13:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LU1xi2My"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DD02135CA
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 13:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737552751; cv=none; b=NiweV5R7AXVtWQ7gS43VZ9jlIUvLWujqR6FdmLq6P1877uW3geBKRQ4xXoNaUhMq7q4dI/mqf4DEVZyCJpaDi75ti2jAHZy/1cXsrM80iFnOVKl3Bxx2pbofZYuD+UE1upggKFkUNVGdM2glWaKSftTuXgyREXPVWsUlJeU5NPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737552751; c=relaxed/simple;
	bh=lcxzeyS7a0otdRQgwjckI/OoCYvCmPjueqIrN+nQ05g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hKP0hCCIskHgklA2y4cpps7Ox4dm3lX96IauDJZjjvig1Dy2D02cnm1kmbXLZ0Uh/ZgEE8YxbYmZjkxVHJjzUPKxOAsasCLWCr4/NKvBhiwEW2nKXo0zGm0FXCfJpCokizhJsUfxSir+afEkMSJRys7N2GyNy27wFWVBagaILiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LU1xi2My; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737552749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WGxCjJpOVgRhQ7tRIZNKtyYICibtpE7J7ZlY21+0Ln8=;
	b=LU1xi2My42QPLKoaS1CHMB/xulSAjzO3IbORO6jA9rEn/1O5wEnbDD4sPhe8ZqCchy9flm
	3hMhGhl1guX+yeZxe7vVq6ZCllhreKJMmoAkT9IWYea1uKaG7mO5XXOgLHmysLVQ9L56sV
	czFeNS7DvCjueAQ9lnZZnfo09+MN2+c=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-y9HWeXfQOKO1tsfCSvCDIw-1; Wed,
 22 Jan 2025 08:32:27 -0500
X-MC-Unique: y9HWeXfQOKO1tsfCSvCDIw-1
X-Mimecast-MFC-AGG-ID: y9HWeXfQOKO1tsfCSvCDIw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA06F1956087;
	Wed, 22 Jan 2025 13:32:25 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.80.118])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 575CE19560A7;
	Wed, 22 Jan 2025 13:32:25 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org
Subject: [PATCH v2 6/7] iomap: advance the iter directly on unshare range
Date: Wed, 22 Jan 2025 08:34:33 -0500
Message-ID: <20250122133434.535192-7-bfoster@redhat.com>
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

Modify unshare range to advance the iter directly. Replace the local
pos and length calculations with direct advances and loop based on
iter state instead.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/iomap/buffered-io.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 5ce5ac13765a..ea140d3098ff 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1267,20 +1267,19 @@ EXPORT_SYMBOL_GPL(iomap_write_delalloc_release);
 static loff_t iomap_unshare_iter(struct iomap_iter *iter)
 {
 	struct iomap *iomap = &iter->iomap;
-	loff_t pos = iter->pos;
-	loff_t length = iomap_length(iter);
-	loff_t written = 0;
+	size_t bytes = iomap_length(iter);
 
 	if (!iomap_want_unshare_iter(iter))
-		return length;
+		return bytes;
 
 	do {
 		struct folio *folio;
 		int status;
 		size_t offset;
-		size_t bytes = min_t(u64, SIZE_MAX, length);
+		loff_t pos = iter->pos;
 		bool ret;
 
+		bytes = min_t(u64, SIZE_MAX, bytes);
 		status = iomap_write_begin(iter, pos, bytes, &folio);
 		if (unlikely(status))
 			return status;
@@ -1298,14 +1297,10 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
 
 		cond_resched();
 
-		pos += bytes;
-		written += bytes;
-		length -= bytes;
-
 		balance_dirty_pages_ratelimited(iter->inode->i_mapping);
-	} while (length > 0);
+	} while ((bytes = iomap_iter_advance(iter, bytes)) > 0);
 
-	return written;
+	return bytes < 0 ? bytes : 0;
 }
 
 int
-- 
2.47.1


