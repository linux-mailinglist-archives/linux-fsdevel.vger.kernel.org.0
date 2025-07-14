Return-Path: <linux-fsdevel+bounces-54883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0913B048B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 22:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB7AA166B53
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 20:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2B023ABB9;
	Mon, 14 Jul 2025 20:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FR1dc8PT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14B5238C2A
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 20:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752525474; cv=none; b=k/POOMkeZuYxPkdlytJ4o1voiTCXSSRSVtKL+yQmSNJ3GNO9mG1c+3gadE+XUQtMnGwY0UBwFUd/bbBmPpOe62B/mcFdtWYGFpbRtXiYTCMnkowsiBp/t7vXXGe7oGWyV6mVcNtUdqdqNQI2wjiCD1ajS+LDvmZtWKa+748B/R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752525474; c=relaxed/simple;
	bh=TRiaionfJobNImoiMJWNErN7LpKtss3cejHSwUe8J+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PREKnZCqlsm1GGr0pD48CS/kTv01lv/jheK9nQbWZcsDl49ZZ7ACuGDTrL6WkIffawgGUjkg/66M9OX3w5V1kOGanUWk4oVWYX2r6N9s8/IJHMHKAcTFjiXf/oTtAEA0W/F4wNLkRtmCR1xflhChBSJiydnBc6k8wEK/LshAiVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FR1dc8PT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752525470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G2oilnYSWpKLUb4WBjfIpxHb6dcWw7CrnL7tLxGTlgo=;
	b=FR1dc8PT2VtrxYBjxtgD8jtWU98tYb0T7U/8zcN2iWoDI4Yig/pfUQNRoht7+S/y4SJqIk
	CBk5K9xRq7Rl+W+bA0M/EFU/hyr2dNGdikuBjhlOLRBJ3ijS7xHChf0Y0beclHOdTs/IKG
	sGN94mN+rNy4VMj5u+c3wKwq6HS7Hzc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-VhtFJ8xJN8OJXh7wlBBIgA-1; Mon,
 14 Jul 2025 16:37:47 -0400
X-MC-Unique: VhtFJ8xJN8OJXh7wlBBIgA-1
X-Mimecast-MFC-AGG-ID: VhtFJ8xJN8OJXh7wlBBIgA_1752525465
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BE4FC1800366;
	Mon, 14 Jul 2025 20:37:45 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.64.43])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9171D19560B2;
	Mon, 14 Jul 2025 20:37:44 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	hch@infradead.org,
	djwong@kernel.org,
	willy@infradead.org
Subject: [PATCH v3 2/7] iomap: remove pos+len BUG_ON() to after folio lookup
Date: Mon, 14 Jul 2025 16:41:17 -0400
Message-ID: <20250714204122.349582-3-bfoster@redhat.com>
In-Reply-To: <20250714204122.349582-1-bfoster@redhat.com>
References: <20250714204122.349582-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The bug checks at the top of iomap_write_begin() assume the pos/len
reflect exactly the next range to process. This may no longer be the
case once the get folio path is able to process a folio batch from
the filesystem. On top of that, len is already trimmed to within the
iomap/srcmap by iomap_length(), so these checks aren't terribly
useful. Remove the unnecessary BUG_ON() checks.

Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 3729391a18f3..38da2fa6e6b0 100644
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
-- 
2.50.0


