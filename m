Return-Path: <linux-fsdevel+bounces-12774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3177786702F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 11:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6306E1C26DC6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 10:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF4169954;
	Mon, 26 Feb 2024 09:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="s1FvJLOV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB6467E79;
	Mon, 26 Feb 2024 09:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708941017; cv=none; b=dAYx5EDivjHCU3dC53xXENCu+wBO+y/fyUDzhey/Z1PsiYIuOViQD+juyFJ0OsJU2ChGZ87hRLlcIatvHFCNMWzxZFBIpDYCysWPW7kFifeG6FiSj2K19+VbNPu5jj5LeQh64lKhF5b3DKIEVRZ8ZJlyWZ1v3BdIRJNh+99zzZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708941017; c=relaxed/simple;
	bh=4ejCWPI5/fRYMUcY9eJYWQ4JohLb3zMfCtxtjMK5oW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ixrAQKVwMXSRNNwXha3A48lmQ3UjpoIoZspHguMfKNmntxesNkoDeBfLT5U/39A5XP4eFC6/2D0t0FtZ9BM7Rw97Tr5+vvDX9AQROnw+yzMyEHomnRfWoTVcj/wuHud2c9LRfMwvxYbR8ctSKEIUsy97KEZ83j4dGxWewQbm1bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=s1FvJLOV; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4TjwpD4yqgz9sQ6;
	Mon, 26 Feb 2024 10:50:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1708941012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i9yxkr7ZYzLuGR2ramAYSlLdnRgu3ddqhwDDXgb/dQg=;
	b=s1FvJLOV6O9BDoEZy9rfAWAdOmTdsY69l/3r70AQ4MWdtRAAjRw8jrLMD2N1T8oH7bb3FE
	Zo5P5AF31/WRErUzGHULK/N/M18PaNHpCSVQ/5UjkSyvUBhL6ARcSVNtDNa7LFFihtGyuX
	zwLRbtKGFial2tfZRA/t6m9w4WUIikd/uSVFERTvKPvVNwLbAywF7r57ufmFDElaWknTj8
	dQx12H3rSonr9IpI4qrobmgSjtp6J/VscSXIGgYelBUaxhicKdv9lyM5eovuOQEre1YR3i
	LWU2h+G8ukjtVd6mKiPDMISh406FjzorZrXGDipZ54XIyY/I6PB1osHX3sl0NA==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	david@fromorbit.com,
	chandan.babu@oracle.com,
	akpm@linux-foundation.org,
	mcgrof@kernel.org,
	ziy@nvidia.com,
	hare@suse.de,
	djwong@kernel.org,
	gost.dev@samsung.com,
	linux-mm@kvack.org,
	willy@infradead.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 07/13] readahead: rework loop in page_cache_ra_unbounded()
Date: Mon, 26 Feb 2024 10:49:30 +0100
Message-ID: <20240226094936.2677493-8-kernel@pankajraghav.com>
In-Reply-To: <20240226094936.2677493-1-kernel@pankajraghav.com>
References: <20240226094936.2677493-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hannes Reinecke <hare@suse.de>

Rework the loop in page_cache_ra_unbounded() to advance with
the number of pages in a folio instead of just one page at a time.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Co-developed-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
---
 mm/readahead.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 325a25e4ee3a..ef0004147952 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -212,7 +212,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 	struct address_space *mapping = ractl->mapping;
 	unsigned long index = readahead_index(ractl);
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
-	unsigned long i;
+	unsigned long i = 0;
 
 	/*
 	 * Partway through the readahead operation, we will have added
@@ -230,7 +230,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 	/*
 	 * Preallocate as many pages as we will need.
 	 */
-	for (i = 0; i < nr_to_read; i++) {
+	while (i < nr_to_read) {
 		struct folio *folio = xa_load(&mapping->i_pages, index + i);
 
 		if (folio && !xa_is_value(folio)) {
@@ -243,8 +243,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 			 * not worth getting one just for that.
 			 */
 			read_pages(ractl);
-			ractl->_index++;
-			i = ractl->_index + ractl->_nr_pages - index - 1;
+			ractl->_index += folio_nr_pages(folio);
+			i = ractl->_index + ractl->_nr_pages - index;
 			continue;
 		}
 
@@ -256,13 +256,14 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
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


