Return-Path: <linux-fsdevel+bounces-18591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CA78BAA46
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 11:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6D9F1F2283E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 09:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B00152171;
	Fri,  3 May 2024 09:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="293Y9NqJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68A814F9DD;
	Fri,  3 May 2024 09:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714730044; cv=none; b=SVEzEB0+0WdlRgqnR4gM3ahwjHH1T9goVXokbn7Kq5Yu4Wek+5ekMCm3jZnbh3GQnUNN6DiUEj+QHt4C+zYgYM8oiBrAZL7yN8ajLGh9IUn0naIMJS59hb2YojDD4YFiFwHRoZH2WzF3pKYNWdX9nfkM1791fDvsecDG6vhqjHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714730044; c=relaxed/simple;
	bh=iqVyyfsLtONeKvpurJXWFzNOaPD/3KBQrlP6i53wPms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nzINbVI+Dd6MTjdRq5Zd2diDqh/vHb8sg3veBdyfoNB/LvvDHssHckbEBxSOWBho3lgP67qipqxcggRJIWw+M/7G0ALwEo3w+O2sfS5bDixxB6xOyA0ch7Q/vf+slJ7SEn7Yc644yn4IuXgfx9IHI2mH98fbfnKGqBiOnWtjsnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=293Y9NqJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=BWTy5cmOf0aa44yjfeQw1CZSOYiM2WGfk1gguG2IQEA=; b=293Y9NqJKACDszg47cyfqZ7M4v
	h7+2Pbm0tHTdYTZ9dakBR/4E67odgQUI0udXr41Ly6Qk0MNrmoS0TYOi+MLOE9BlGsHRnRcMcl+4S
	CaAF8BOvbDd1VyuKeF68xJcE+t75GvdzX2YDVD3pCDB7DKIPRvNX1NXu1/ER6IR+vSuuvNO1LGv7O
	PPXo1oLvasFrtdJOT1fqnRrNQ6QTlSApW+UZIHPU6BUwfO0BJVf/Dx8p9g9XQ3bvbrSZAiXO1WsFP
	xMIqfY+lpNUuDS6tJ2anjczVN1GObUX1NdrLTpMJg0phu7xOADlVnrwBlnAcHGihyjF5e65DnXkxW
	tTyQgE7g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2pc2-0000000Fw3N-42gB;
	Fri, 03 May 2024 09:53:54 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: akpm@linux-foundation.org,
	willy@infradead.org,
	djwong@kernel.org,
	brauner@kernel.org,
	david@fromorbit.com,
	chandan.babu@oracle.com
Cc: hare@suse.de,
	ritesh.list@gmail.com,
	john.g.garry@oracle.com,
	ziy@nvidia.com,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	kernel@pankajraghav.com,
	mcgrof@kernel.org
Subject: [PATCH v5 01/11] readahead: rework loop in page_cache_ra_unbounded()
Date: Fri,  3 May 2024 02:53:43 -0700
Message-ID: <20240503095353.3798063-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240503095353.3798063-1-mcgrof@kernel.org>
References: <20240503095353.3798063-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

From: Hannes Reinecke <hare@suse.de>

Rework the loop in page_cache_ra_unbounded() to advance with
the number of pages in a folio instead of just one page at a time.

Note that the index is incremented by 1 if filemap_add_folio() fails
because the size of the folio we are trying to add is 1 (order 0).

Signed-off-by: Hannes Reinecke <hare@suse.de>
Co-developed-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
---
 mm/readahead.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 130c0e7df99f..2361634a84fd 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -208,7 +208,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 	struct address_space *mapping = ractl->mapping;
 	unsigned long index = readahead_index(ractl);
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
-	unsigned long i;
+	unsigned long i = 0;
 
 	/*
 	 * Partway through the readahead operation, we will have added
@@ -226,7 +226,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 	/*
 	 * Preallocate as many pages as we will need.
 	 */
-	for (i = 0; i < nr_to_read; i++) {
+	while (i < nr_to_read) {
 		struct folio *folio = xa_load(&mapping->i_pages, index + i);
 
 		if (folio && !xa_is_value(folio)) {
@@ -239,8 +239,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 			 * not worth getting one just for that.
 			 */
 			read_pages(ractl);
-			ractl->_index++;
-			i = ractl->_index + ractl->_nr_pages - index - 1;
+			ractl->_index += folio_nr_pages(folio);
+			i = ractl->_index + ractl->_nr_pages - index;
 			continue;
 		}
 
@@ -252,13 +252,14 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 			folio_put(folio);
 			read_pages(ractl);
 			ractl->_index++;
-			i = ractl->_index + ractl->_nr_pages - index - 1;
+			i = ractl->_index + ractl->_nr_pages - index;
 			continue;
 		}
 		if (i == nr_to_read - lookahead_size)
 			folio_set_readahead(folio);
 		ractl->_workingset |= folio_test_workingset(folio);
-		ractl->_nr_pages++;
+		ractl->_nr_pages += folio_nr_pages(folio);
+		i += folio_nr_pages(folio);
 	}
 
 	/*
-- 
2.43.0


