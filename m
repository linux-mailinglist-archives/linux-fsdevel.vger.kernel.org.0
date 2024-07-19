Return-Path: <linux-fsdevel+bounces-24027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34203937BD6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 19:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAD321F22C4A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 17:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC5F146D6F;
	Fri, 19 Jul 2024 17:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hil31Etm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41137146596;
	Fri, 19 Jul 2024 17:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721411474; cv=none; b=KZYMK/CDKihU/mABe7VuTZSpdK1/w92Bu13cn5aDO5LafxrnOjshWC7NBPkHIaEID4HIghwD/FVUVX2C9WyrdFITo1oEHR8yAQnP1b4CfaPTWFEFRFDLNsQUcqhnRaRCFkSPnFFB87jO6TM912zUhj7ZRGRIEmqgQWTxQOLrlyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721411474; c=relaxed/simple;
	bh=668wruYKqTlX2OlgmloCRxOZ8vcc8WRLkQxZhuiTR78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRYGiuMzydis9f38wVwh155HaX6ceP2Tp0dzLtGlMreBGDKypi1cHG+7vDP+GMEiNAJWPkoF59GcvnUy1BQbdHRaNaZoWCQIBbykRGjnSrRV0uo1tfv/v+8U2Mr4kb1Yz7ywE+HY9xyBD3FF1oRz2SDqSQdiyAlm+5ZWTC5QyW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hil31Etm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=hNCmfsxI0q3xcOvhqLyZslnw0lr+9M7PVLR4Pgdqv8A=; b=hil31EtmzjsU7WH0hd5jDmP05E
	hkR6FG4G3w+klWITvjMOOlLShPngiKRMDbmPDQWg4/oV6I+s/srMdfVgKXDIkkeZTxNNqAvAJv6/6
	HBj+/T/mGVHItadXBW/eJxNPWe33yVL561c4wi+ekEXvJWSKiH7513rTEyFe4+q00LGyTwKfI7MVc
	QsQ1Q4IoGhPnOPk87/JrDsVluDBLU45HbEpfvTqpSjvzWtUGhBQ6lPamDhXJEZTie3XGN4xGwmRiq
	Du8jk7tBNaMJBDqs+WiKGrRHKmp85ikfNMndLAXzsTr+xwfHeHrUM3WSDhDcE8QjvdLg39KZ3mahs
	pkMkmQTw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUrl9-00000003J4t-2QoD;
	Fri, 19 Jul 2024 17:51:11 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/4] gfs2: Remove gfs2_aspace_writepage()
Date: Fri, 19 Jul 2024 18:51:04 +0100
Message-ID: <20240719175105.788253-5-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240719175105.788253-1-willy@infradead.org>
References: <20240719175105.788253-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are no remaining callers of gfs2_aspace_writepage() other than
vmscan, which is known to do more harm than good.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/gfs2/meta_io.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index cfb204c9396c..fea3efcc2f93 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -86,13 +86,6 @@ static void gfs2_aspace_write_folio(struct folio *folio,
 		folio_end_writeback(folio);
 }
 
-static int gfs2_aspace_writepage(struct page *page, struct writeback_control *wbc)
-{
-	gfs2_aspace_write_folio(page_folio(page), wbc);
-
-	return 0;
-}
-
 static int gfs2_aspace_writepages(struct address_space *mapping,
 		struct writeback_control *wbc)
 {
@@ -115,7 +108,6 @@ const struct address_space_operations gfs2_meta_aops = {
 const struct address_space_operations gfs2_rgrp_aops = {
 	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
-	.writepage = gfs2_aspace_writepage,
 	.writepages = gfs2_aspace_writepages,
 	.release_folio = gfs2_release_folio,
 };
-- 
2.43.0


