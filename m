Return-Path: <linux-fsdevel+bounces-50763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A160ACF55E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 19:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB336165D23
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 17:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB9C1EA7CF;
	Thu,  5 Jun 2025 17:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MunOb5UY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066E21922FB
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jun 2025 17:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749144634; cv=none; b=Xy5igr1zJ7iAXEowXnFHxQKeYvc5y7E0gAtF//FH8ufKEHiVY7nsCeFqJqtSzxaAxzTgJv+xN36UhIsKuSQF2srV+xX59HqwiBzXRASQA4VUvcmV2uhevvQX2eMcycRSn09W4+Ey2+HHoeiNZVIDUpHAuAVnPHikRVHFsQGIn1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749144634; c=relaxed/simple;
	bh=nnhfQmVxsGRqDoH2tnTDXoHo+QKGfoMQuvpHrqKogYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L/gwoaNyUcp7rObytwX5Iwx33ZorxwATKL6qcAvx2cGZJVz+KuNZl9NpU/aIHN0QFoRSAPdrk7/vrrtJOcNccKHYLiIQAPtA0wIIesluOSIhv3VXTi28xnC6Me9K4fAibTxRBPibFEB5NXvwt14gsSJh8U+1eAwlHBfPNGcNTE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MunOb5UY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749144631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fprpw+4DgNE3ISMvsmQurCKFtzAFsAvCo9SkQM8nkXE=;
	b=MunOb5UY4zO8rwtXY8knyn6Mgmu4acyS0qFNtgTe1VMSXzWcsM5BEpHrbCoASfNJNQuImU
	sPZ9D8Fx1F0HddL6TqwzHNF7t3iwWMKtpxazCo2EH9IWi6Gu5iQu3CMoX+pFZQSBQGGV6I
	2FtuxIyE733sY4K3SMvlNddh9gktBww=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-6o6q7BhsM0Oy_ARoN9zfpQ-1; Thu,
 05 Jun 2025 13:30:30 -0400
X-MC-Unique: 6o6q7BhsM0Oy_ARoN9zfpQ-1
X-Mimecast-MFC-AGG-ID: 6o6q7BhsM0Oy_ARoN9zfpQ_1749144629
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 387B8195608B;
	Thu,  5 Jun 2025 17:30:29 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.123])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5C5B330002C0;
	Thu,  5 Jun 2025 17:30:28 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/7] iomap: move pos+len BUG_ON() to after folio lookup
Date: Thu,  5 Jun 2025 13:33:51 -0400
Message-ID: <20250605173357.579720-2-bfoster@redhat.com>
In-Reply-To: <20250605173357.579720-1-bfoster@redhat.com>
References: <20250605173357.579720-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The bug checks at the top of iomap_write_begin() assume the pos/len
reflect exactly the next range to process. This may no longer be the
case once the get folio path is able to process a folio batch from
the filesystem. Move the check a bit further down after the folio
lookup and range trim to verify everything lines up with the current
iomap.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/iomap/buffered-io.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 3729391a18f3..16499655e7b0 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -805,15 +805,12 @@ static int iomap_write_begin(struct iomap_iter *iter, struct folio **foliop,
 {
 	const struct iomap_folio_ops *folio_ops = iter->iomap.folio_ops;
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
-	loff_t pos = iter->pos;
+	loff_t pos;
 	u64 len = min_t(u64, SIZE_MAX, iomap_length(iter));
 	struct folio *folio;
 	int status = 0;
 
 	len = min_not_zero(len, *plen);
-	BUG_ON(pos + len > iter->iomap.offset + iter->iomap.length);
-	if (srcmap != &iter->iomap)
-		BUG_ON(pos + len > srcmap->offset + srcmap->length);
 
 	if (fatal_signal_pending(current))
 		return -EINTR;
@@ -843,6 +840,9 @@ static int iomap_write_begin(struct iomap_iter *iter, struct folio **foliop,
 	}
 
 	pos = iomap_trim_folio_range(iter, folio, poffset, &len);
+	BUG_ON(pos + len > iter->iomap.offset + iter->iomap.length);
+	if (srcmap != &iter->iomap)
+		BUG_ON(pos + len > srcmap->offset + srcmap->length);
 
 	if (srcmap->type == IOMAP_INLINE)
 		status = iomap_write_begin_inline(iter, folio);
-- 
2.49.0


