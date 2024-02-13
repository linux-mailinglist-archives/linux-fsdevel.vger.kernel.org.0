Return-Path: <linux-fsdevel+bounces-11339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BAB852C87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 10:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 447041C247BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 09:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB1A3D977;
	Tue, 13 Feb 2024 09:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="x6CfVQAW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6309338F8F;
	Tue, 13 Feb 2024 09:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707817064; cv=none; b=iufK3/yXLKOZTi9sQ2478PAw+hW5YGSE0x3fZOFIt6kFGDKZNYMbFgeOJ5woqwc1E3GBz7mjOcu0fTD8n3ZMOHdsjJZckZHRecHU9cIaFOGFpQYch6BKycCRicCit2PFT4qn3E0vjpahBOncL7vg5Hy0CRM/i4DqImpC1LBK2vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707817064; c=relaxed/simple;
	bh=iKbT79kLd7jyelrjB7xgHQdWAkRrlZn0Y/6yOzWx3k0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rgbRqsrkqJdXPytkrXlwCL1qQLEDhezD1CpX3n4Jn0s/M3Wo/8rlISPqpeplhwogEg8YdAUaiTTxB82FssDP/U51MTRzJV6At3NofT5NQGbGGPpE2deVRMsikC3MBblIRzmzD+WM6F2fe1JQOSrMNfqxRJpTGHTc9O4vooXdEq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=x6CfVQAW; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4TYx7l4ntmz9t2m;
	Tue, 13 Feb 2024 10:37:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1707817059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s3+v+1l0sQIYfL9D8O6cM5bMDlwybIjei48bqSTyWjw=;
	b=x6CfVQAW4rNsG3L+k95kHbFRenuHprAKwdKZE4SqzOwOs2L6aGmZ1ZQVD8/dJoBhJywTa7
	6y8PrO1+vcd3D+x0Iqy3adhK62udO+kGv47JGmZGPVG7qqwA+gbeU/NJnY92pbJuF1EY0l
	JUstg7eTNj265zR9KXR68yLq9hPsVt7JMoLc8i9Yuiv2JGdztsLselFJepClTBB/njp9tI
	RG6HjSx+PGhFCUnsXbC9mYVgrbZ+ICPlPMhuKs9iRc8QUGmTUZSCWlB/fNXayyoq4+anHk
	uone6GAIEb5xnuUWMx9ouMcbT5CHsJzw8G3PIZcC8sKASsD5Z5GQy5wGcDz+jQ==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: mcgrof@kernel.org,
	gost.dev@samsung.com,
	akpm@linux-foundation.org,
	kbusch@kernel.org,
	djwong@kernel.org,
	chandan.babu@oracle.com,
	p.raghav@samsung.com,
	linux-kernel@vger.kernel.org,
	hare@suse.de,
	willy@infradead.org,
	linux-mm@kvack.org,
	david@fromorbit.com
Subject: [RFC v2 06/14] readahead: rework loop in page_cache_ra_unbounded()
Date: Tue, 13 Feb 2024 10:37:05 +0100
Message-ID: <20240213093713.1753368-7-kernel@pankajraghav.com>
In-Reply-To: <20240213093713.1753368-1-kernel@pankajraghav.com>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4TYx7l4ntmz9t2m

From: Hannes Reinecke <hare@suse.de>

Rework the loop in page_cache_ra_unbounded() to advance with
the number of pages in a folio instead of just one page at a time.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Co-developed-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 mm/readahead.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 5e1ec7705c78..13b62cbd3b79 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -213,7 +213,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 	struct address_space *mapping = ractl->mapping;
 	unsigned long index = readahead_index(ractl);
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
-	unsigned long i;
+	unsigned long i = 0;
 
 	/*
 	 * Partway through the readahead operation, we will have added
@@ -231,7 +231,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 	/*
 	 * Preallocate as many pages as we will need.
 	 */
-	for (i = 0; i < nr_to_read; i++) {
+	while (i < nr_to_read) {
 		struct folio *folio = xa_load(&mapping->i_pages, index + i);
 
 		if (folio && !xa_is_value(folio)) {
@@ -244,8 +244,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 			 * not worth getting one just for that.
 			 */
 			read_pages(ractl);
-			ractl->_index++;
-			i = ractl->_index + ractl->_nr_pages - index - 1;
+			ractl->_index += folio_nr_pages(folio);
+			i = ractl->_index + ractl->_nr_pages - index;
 			continue;
 		}
 
@@ -257,13 +257,14 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
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


