Return-Path: <linux-fsdevel+bounces-40092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFD2A1BE92
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 23:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B84383A8FC6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 22:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF0B1E7C21;
	Fri, 24 Jan 2025 22:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M77uMF7m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9443A18A93E;
	Fri, 24 Jan 2025 22:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737758929; cv=none; b=tVVYcplFrODRPpTszg3wpZaf9IYEz9dCricYlzWkV0O2o3k1E/0JyeOCdv3JWunQYIYjozCWTAVizE0okFd+04PgPUp7WydTXYtSaIMIwFBOcV2t1ikKtWmnz/BCKQsQUDFSZL+YXVLiHiJmQS6uUPd15fckSlDNmKV9APkoxPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737758929; c=relaxed/simple;
	bh=5UvO8xV/TH7ATR2Bbw80jDXUq5jmOeJfhpnVgn3d5F0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FmE99WhpM79N6P1999Gi+0VU+Se2Texs5W96CvF1U8gyVJ5k1lBXfspvVrN3oN/dFBIxs19oABkdtcFo2ccxlKzBxaRWAekWKARA4pTHyMfYfso3VxbwUn9D3TQcZQJO+MXi/5reS+ql9ASKrRXBLY8YU433An8ro9eS/zup1NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M77uMF7m; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=sL8io6Ogy3tJI6VLP/NMc9XdkDtY/hwHMQ1XfBAdOus=; b=M77uMF7m5thKuIcC1WXWpGX43A
	f6dgfrTHh316HxHRzFwpf8AgeQp9J1cUmyrIWXylh6ppQGoFYbqCdjBGAtUGAjwDbqNAbXgt067PD
	VnNm28te8WQgmSdGqWX8CEUpMq3aPVvSLFu7qyZAkIv6v+hnzhBmG4Z7QRBw1k50QR5zV2hu+LGXn
	YqDPRQooK3UdCMDm4tmdwuaEcRbutFjUDZSdhRlfR7v18wA3tDqSt4dvr0vvOe33vUBYBarkHZuIo
	7GTh/z93RgAynMlfPFv9cPl556T6ejg/7hVPuxyTTgkX1pQOJos5l3lwYr1Tian1VtxM9stkd/yu4
	+LhAkEAQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tbSTk-00000001M3d-1ych;
	Fri, 24 Jan 2025 22:48:44 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Andres Freund <andres@anarazel.de>
Subject: [PATCH] block: Skip the folio lock if the folio is already dirty
Date: Fri, 24 Jan 2025 22:48:29 +0000
Message-ID: <20250124224832.322771-1-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Postgres sees significant contention on the hashed folio waitqueue lock
when performing direct I/O to 1GB hugetlb pages.  This is because we
mark the destination pages as dirty, and the locks end up 512x more
contended with 1GB pages than with 2MB pages.

We can skip the locking if the folio is already marked as dirty.
The writeback path clears the dirty flag before commencing writeback,
if we see the dirty flag set, the data written to the folio will be
written back.

In one test, throughput increased from 18GB/s to 20GB/s and moved the
bottleneck elsewhere.

Reported-by: Andres Freund <andres@anarazel.de>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 block/bio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index f0c416e5931d..e8d18a0fecb5 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1404,6 +1404,8 @@ void bio_set_pages_dirty(struct bio *bio)
 	struct folio_iter fi;
 
 	bio_for_each_folio_all(fi, bio) {
+		if (folio_test_dirty(folio))
+			continue;
 		folio_lock(fi.folio);
 		folio_mark_dirty(fi.folio);
 		folio_unlock(fi.folio);
-- 
2.45.2


