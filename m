Return-Path: <linux-fsdevel+bounces-42103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DF8A3C69D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 18:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16A807A6013
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 17:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B14214A65;
	Wed, 19 Feb 2025 17:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OZg2Zi7S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC12214814
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2025 17:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987306; cv=none; b=o3MLsOTdZVFjQUDKYtTiHfAWbr++Btlexw8P+kwKF8kvFPY+TzVuLfZ3xqzvtP8d+dWVxThwc9EkAitj1Y72iSuAnh4CZW1kt/+nPs2gNrejnB+Lbc2McDWv+Lc2Zc3vkhv4ZZUyoDg0OyVrpDxWwmxqnVNF5MjW4nFJsLDfMd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987306; c=relaxed/simple;
	bh=7b9AQgXNEIXF4TVAOzkm5XAL7s+dqoTJmDghaHlEPYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cVQ5J5QLjoXqIVSIvEdS6Kzwj6ut9evsvlQR+ue2HAdBYQqznN0duEjMs+54c/jz4VATH5/WHjrIZaTw1usEAj4IPoCQM79liNrlWhCsG+NdTw2Rf0LPsSY3hgvghnK3kkkhFMjgSTo95aEFIUQP0YxG4Gk8/DLJSFirgdE/AEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OZg2Zi7S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739987304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BmO4mJXcmBj+oHldtB2Fxd71xiVSavLuKkDp346mb+M=;
	b=OZg2Zi7St4NQimInnSbX1KtQ2B6X6sBcoAlEj5Mza4srIS5Sotwf6cpjHSuUUd9Tn9SK2q
	zVbt8bVHLWkK7cQ170rFDM2Gh4WZDkQxXwk+sX4Chdl0QkVpXlySxuiMhpcnNCfChp1tw6
	8KnjHyyZPLtYt6FMGk9i2u6BbyzA9/4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-YVrjaMWoOfW6-U4UYs1xyQ-1; Wed,
 19 Feb 2025 12:48:20 -0500
X-MC-Unique: YVrjaMWoOfW6-U4UYs1xyQ-1
X-Mimecast-MFC-AGG-ID: YVrjaMWoOfW6-U4UYs1xyQ_1739987299
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BC5AA18E6952;
	Wed, 19 Feb 2025 17:48:19 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.79])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CC5A01800362;
	Wed, 19 Feb 2025 17:48:18 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v2 05/12] dax: push advance down into dax_iomap_iter() for read and write
Date: Wed, 19 Feb 2025 12:50:43 -0500
Message-ID: <20250219175050.83986-6-bfoster@redhat.com>
In-Reply-To: <20250219175050.83986-1-bfoster@redhat.com>
References: <20250219175050.83986-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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


