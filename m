Return-Path: <linux-fsdevel+bounces-40094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E509CA1BE99
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 23:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 428E716E691
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 22:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645BA1E98EA;
	Fri, 24 Jan 2025 22:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mSSDvrXL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A06318A93E;
	Fri, 24 Jan 2025 22:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737759074; cv=none; b=ctqdxFqaTAusLmBIUqiHVwyRDlHiMYbF0QF1M/K0tED4UxNtXXP2SjQZWudqN9Jf0LsV1sD2Wmuqp/HoNNoaFhDBXwuNn3X06KBxdohsdl0aLJgWw+76ONq++4ViO05Mb79nOJy3JpxnaX9+ZjYdUCpSC1yRNi5LrrtbZ1nZ/GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737759074; c=relaxed/simple;
	bh=/4ia0cKzOQoJsdsRk6UHyV8zwNTGzhHMTsimoeWVHb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mvdhnTTmiVRpy6paQB0jknbJ5zfx1OaoeyBvyYPMDGfkz9Ge6D0fEBL7pHfrUYcR5f+HeeIyLNluWF8q4cPaNWaJmPc0SrCGL01TP1k2GfzZDEb+GXMS4dgqXwasZkP30MveqPUKaj1bM47vLB8pqp2vMJbnzSa4r/qVicgPGk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mSSDvrXL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=ONWpJCQ1y00OH6khfXOorwlc6DOA2hoNVf6rj3r415k=; b=mSSDvrXLHDHaJ7EETzZqcol+L9
	aQqG11IdzpunfkNU/3p9wBluCbkh63f+B7K7KCitdir9MuUxm1raLnes16gAzD2z6Y5nfqg+ZfJdm
	KoN1opGDxUsKejCki1u1TwOkKxicCTS8GahOoarsdGy7Fo2qtVxRFcPso6SpzFRp5QSJ7dt0pVrkH
	eU3ZaVQXeOCZes+55eYTxVt0MFO8RENG3HWCS7DIwVJ/x3gM9XnV5953FBjACWLK/sKMxO8ekhCb7
	VON/BcObaTBmtxZkevtitKGBnMRqonZxrB4PL54yGzkvNUdsHDNIOQ+s74RRY+/zItlQJLbFdIdAd
	p3sw5wSA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tbSW6-00000001N2G-45Iz;
	Fri, 24 Jan 2025 22:51:11 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Andres Freund <andres@anarazel.de>
Subject: [PATCH] block: Skip the folio lock if the folio is already dirty
Date: Fri, 24 Jan 2025 22:51:02 +0000
Message-ID: <20250124225104.326613-1-willy@infradead.org>
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
index f0c416e5931d..58d30b1dc08e 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1404,6 +1404,8 @@ void bio_set_pages_dirty(struct bio *bio)
 	struct folio_iter fi;
 
 	bio_for_each_folio_all(fi, bio) {
+		if (folio_test_dirty(fi.folio))
+			continue;
 		folio_lock(fi.folio);
 		folio_mark_dirty(fi.folio);
 		folio_unlock(fi.folio);
-- 
2.45.2


