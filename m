Return-Path: <linux-fsdevel+bounces-42426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFD3A4244D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 15:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9576919C4E75
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 14:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5147F14B080;
	Mon, 24 Feb 2025 14:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VeB9QwhT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF8724169C
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 14:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408333; cv=none; b=UB8dpJ5bgSG+5ayaIcbQnDmatc4j831bT6tGc0UDzbRJe3yCGaP3yCKeeDQKwOJXgDWFMJNkl7x+k5AYjScYN9H8fX6w8/QTKfDsF9fH9fQQjS76UJf223RyCFplKU8UvH/G2+UPzzscqu145Q1is4gHE/tiR4jJHzSCqiPT3sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408333; c=relaxed/simple;
	bh=vQsz47SxnCcUZ17hmyqxM6BagthYhmwgQn/8CjSl/7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LMckTNG8Wus2zZV7n7jlXaHrb9dRIPNtxxwqlEgS6sUILcT7p9rdVPGL9u4N41uIwP+N6sgZSaZgmTfiZ51OatnzePy+Af15yalGaU0/Ins4ODhCgsNuUwgaW6h7s5t0nnxItR89FYOg67YqZagQMfKGovBqYivy/Ek0jvf+IrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VeB9QwhT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740408331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xeTgW91EqW2rIu/VRzRweVhDUwY9iHwNHUu48m45Ptg=;
	b=VeB9QwhTA3YZC9qWbeaH9vKt3380YdBm9h+qkz0rdgi97S1JcbaaFNliiBc1iZIdzBDicp
	Sq65+o1J4B74n03DSgvZHqAzsdcNtxi2A+Qmdm+FehHbpMj1Ns9tIABeTTe4s5KLXLae9t
	Aqfhq+Gf3eSWRo9UjIn7drHIJGa7Mvo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-WlOcLlhhPSyIohp2UiF5UA-1; Mon,
 24 Feb 2025 09:45:27 -0500
X-MC-Unique: WlOcLlhhPSyIohp2UiF5UA-1
X-Mimecast-MFC-AGG-ID: WlOcLlhhPSyIohp2UiF5UA_1740408326
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 73E8518D95F1;
	Mon, 24 Feb 2025 14:45:26 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.79])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 61B5619560AA;
	Mon, 24 Feb 2025 14:45:25 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v3 05/12] dax: push advance down into dax_iomap_iter() for read and write
Date: Mon, 24 Feb 2025 09:47:50 -0500
Message-ID: <20250224144757.237706-6-bfoster@redhat.com>
In-Reply-To: <20250224144757.237706-1-bfoster@redhat.com>
References: <20250224144757.237706-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

DAX read and write currently advances the iter after the
dax_iomap_iter() returns the number of bytes processed rather than
internally within the iter handler itself, as most other iomap
operations do. Push the advance down into dax_iomap_iter() and
update the function to return op status instead of bytes processed.

dax_iomap_iter() shortcuts reads from a hole or unwritten mapping by
directly zeroing the iov_iter, so advance the iomap_iter similarly
in that case.

The DAX processing loop can operate on a range slightly different
than defined by the iomap_iter depending on circumstances. For
example, a read may be truncated by inode size, a read or write
range can be increased due to page alignment, etc. Therefore, this
patch aims to retain as much of the existing logic as possible.

The loop control logic remains pos based, but is sampled from the
iomap_iter on each iteration after the advance instead of being
updated manually. Similarly, length is updated based on the output
of the advance instead of being updated manually. The advance itself
is based on the number of bytes transferred, which was previously
used to update the local copies of pos and length.

Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/dax.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 296f5aa18640..139e299e53e6 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1431,8 +1431,7 @@ int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 }
 EXPORT_SYMBOL_GPL(dax_truncate_page);
 
-static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
-		struct iov_iter *iter)
+static int dax_iomap_iter(struct iomap_iter *iomi, struct iov_iter *iter)
 {
 	const struct iomap *iomap = &iomi->iomap;
 	const struct iomap *srcmap = iomap_iter_srcmap(iomi);
@@ -1451,8 +1450,10 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 		if (pos >= end)
 			return 0;
 
-		if (iomap->type == IOMAP_HOLE || iomap->type == IOMAP_UNWRITTEN)
-			return iov_iter_zero(min(length, end - pos), iter);
+		if (iomap->type == IOMAP_HOLE || iomap->type == IOMAP_UNWRITTEN) {
+			done = iov_iter_zero(min(length, end - pos), iter);
+			return iomap_iter_advance(iomi, &done);
+		}
 	}
 
 	/*
@@ -1485,7 +1486,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 	}
 
 	id = dax_read_lock();
-	while (pos < end) {
+	while ((pos = iomi->pos) < end) {
 		unsigned offset = pos & (PAGE_SIZE - 1);
 		const size_t size = ALIGN(length + offset, PAGE_SIZE);
 		pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
@@ -1535,18 +1536,16 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 			xfer = dax_copy_to_iter(dax_dev, pgoff, kaddr,
 					map_len, iter);
 
-		pos += xfer;
-		length -= xfer;
-		done += xfer;
-
-		if (xfer == 0)
+		length = xfer;
+		ret = iomap_iter_advance(iomi, &length);
+		if (!ret && xfer == 0)
 			ret = -EFAULT;
 		if (xfer < map_len)
 			break;
 	}
 	dax_read_unlock(id);
 
-	return done ? done : ret;
+	return ret;
 }
 
 /**
@@ -1585,12 +1584,8 @@ dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		iomi.flags |= IOMAP_NOWAIT;
 
-	while ((ret = iomap_iter(&iomi, ops)) > 0) {
+	while ((ret = iomap_iter(&iomi, ops)) > 0)
 		iomi.processed = dax_iomap_iter(&iomi, iter);
-		if (iomi.processed > 0)
-			iomi.processed = iomap_iter_advance(&iomi,
-							    &iomi.processed);
-	}
 
 	done = iomi.pos - iocb->ki_pos;
 	iocb->ki_pos = iomi.pos;
-- 
2.48.1


