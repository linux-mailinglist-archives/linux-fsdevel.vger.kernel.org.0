Return-Path: <linux-fsdevel+bounces-9817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A3584537F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 10:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06CC2B27D3C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 09:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6988815B97B;
	Thu,  1 Feb 2024 09:13:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC69715B964;
	Thu,  1 Feb 2024 09:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706778800; cv=none; b=Npc6coOljiGRxmXGYRMySCci1lmvLszUCua64aqOtPBRd5Iu1HGwHFbGsOGacIjgEcF5+ETzBGribYvOzqphkcnmBfjStquwp8oSlcZC/4CTVtzpQRrk7oGuKU8UY7PXyiAufzNObAJn3UV2ni3cGoMLxt0BnyhmMJ78fbsiHrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706778800; c=relaxed/simple;
	bh=cIwDUt+abyULJ5+fBvoBdeOcF9SxefKTziWM9T99Ad8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UTvkhZz0Q4P6t8dE69nM0V9si5CZc1iHPCVbWH4xlHdvlP1qPLr349OPAmox+unWGMVQWzO4pDzSRIiuFbXBc2spcu3XbT6EeAXn1Z/cMxivRMqBhaeG3ISp3T9+v2Xle/W5c0eklXtl072tU5h13eF1Y3R1tCAAYL1FPaX/HJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4TQY7c3fSJz1Q8hG;
	Thu,  1 Feb 2024 17:11:56 +0800 (CST)
Received: from dggpemd200004.china.huawei.com (unknown [7.185.36.141])
	by mail.maildlp.com (Postfix) with ESMTPS id 971BA1401E0;
	Thu,  1 Feb 2024 17:13:09 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemd200004.china.huawei.com
 (7.185.36.141) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.28; Thu, 1 Feb
 2024 17:13:09 +0800
From: Liu Shixin <liushixin2@huawei.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	<brauner@kernel.org>, Jan Kara <jack@suse.cz>, Matthew Wilcox
	<willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH 1/2] mm/readahead: stop readahead loop if memcg charge fails
Date: Thu, 1 Feb 2024 18:08:34 +0800
Message-ID: <20240201100835.1626685-2-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240201100835.1626685-1-liushixin2@huawei.com>
References: <20240201100835.1626685-1-liushixin2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemd200004.china.huawei.com (7.185.36.141)

When a task in memcg readaheads file pages, page_cache_ra_unbounded()
will try to readahead nr_to_read pages. Even if the new allocated page
fails to charge, page_cache_ra_unbounded() still tries to readahead
next page. This leads to too much memory reclaim.

Stop readahead if mem_cgroup_charge() fails, i.e. add_to_page_cache_lru()
returns -ENOMEM.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
Signed-off-by: Jinjiang Tu <tujinjiang@huawei.com>
---
 mm/readahead.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 23620c57c1225..cc4abb67eb223 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -228,6 +228,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 	 */
 	for (i = 0; i < nr_to_read; i++) {
 		struct folio *folio = xa_load(&mapping->i_pages, index + i);
+		int ret;
 
 		if (folio && !xa_is_value(folio)) {
 			/*
@@ -247,9 +248,12 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 		folio = filemap_alloc_folio(gfp_mask, 0);
 		if (!folio)
 			break;
-		if (filemap_add_folio(mapping, folio, index + i,
-					gfp_mask) < 0) {
+
+		ret = filemap_add_folio(mapping, folio, index + i, gfp_mask);
+		if (ret < 0) {
 			folio_put(folio);
+			if (ret == -ENOMEM)
+				break;
 			read_pages(ractl);
 			ractl->_index++;
 			i = ractl->_index + ractl->_nr_pages - index - 1;
-- 
2.25.1


