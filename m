Return-Path: <linux-fsdevel+bounces-41405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A71FCA2EE59
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 14:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF0E17A1C54
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 13:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A5D22655C;
	Mon, 10 Feb 2025 13:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aoGBQNTG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ABB22FF52;
	Mon, 10 Feb 2025 13:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739194505; cv=none; b=iymnWyxaVz3Q61WUWFYvV+BvsKUPra0ddLIdcq5Te0i2i30j8d1R1UQylUoyUkbTLWQolx5NEHQMpn+fEADV3Bi6MWGRzs2j09g+v+qXvCklL7ZXUTxWaAb1ocK7sFZVJXAxbc47lVjKIBG9XRNVdT3Q2Rm4z+yit2civmXI+44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739194505; c=relaxed/simple;
	bh=E2eO4+9j80iJ2o4sXbky7mC8xtI7dCikzbB4i+qDbw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cmyrqzwXrZRYpedwtxEVd6EIBp9y8r+TvZVP/63nwVGPujRS/61oBDUIetv+E/rRyhn7QBQcjqB4wUo3uGeHVVf4Ljr0dtNBvYLAO8WlkGFrJNf0dL5UMfoRZsLXRQz6TLZyubSKCX7vgi8F3ABACYSgEHhONFwQlVdmD4KWT4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aoGBQNTG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=BXOqBE20TDdvRRVcehY9pob5yLtgBqzqb3aZO2uPEyI=; b=aoGBQNTG/Qjhc5Vq7dr6nDcVuf
	zruAlx8UyTQLm7NrHskPmjYq1sVyLgVGpP4kYnK5UJ1aNotdcjYiLMR27wRaYDSUM2qDOYZBpjZeS
	7wteARxKqm/iHV+Bx/jluEo4JOhOIhoFeWofITx3if6slIr3AJJj+UWnoXeZi3J2+Cg56kqm0qdK2
	E8NU5q93CQSqA8QZiyCZj5yfgC2WnduJ2iRWAjJFJ+RMALleio4LadO5jHWMI92+EFH6AbnZScLG0
	ywR2K1+PnFwvxAI51T2qUrnRRSlHwUXBW01I8VM4SE6GiRu2ErVkG+1ywdmHrDbxUPOLHN4rxbNWW
	Qg5CMEMw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1thTw5-0000000FvZs-3q2K;
	Mon, 10 Feb 2025 13:34:53 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/8] gfs2: Use b_folio in gfs2_submit_bhs()
Date: Mon, 10 Feb 2025 13:34:41 +0000
Message-ID: <20250210133448.3796209-4-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210133448.3796209-1-willy@infradead.org>
References: <20250210133448.3796209-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove a reference to bh->b_page which is going to be removed soon.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/gfs2/meta_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index fea3efcc2f93..66db506a5f7f 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -232,7 +232,7 @@ static void gfs2_submit_bhs(blk_opf_t opf, struct buffer_head *bhs[], int num)
 		bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 		while (num > 0) {
 			bh = *bhs;
-			if (!bio_add_page(bio, bh->b_page, bh->b_size, bh_offset(bh))) {
+			if (!bio_add_folio(bio, bh->b_folio, bh->b_size, bh_offset(bh))) {
 				BUG_ON(bio->bi_iter.bi_size == 0);
 				break;
 			}
-- 
2.47.2


