Return-Path: <linux-fsdevel+bounces-15069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4382886963
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 10:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5E161C238C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 09:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98C7383B9;
	Fri, 22 Mar 2024 09:36:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F987224FA;
	Fri, 22 Mar 2024 09:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711100186; cv=none; b=Zn1wrNqbPB/UYYREAQFvHrqMXv5slP6jIaBun+yvG/tkbXJWaSmRU9qWxSmzgkHr4SeTi3Ba4hXg7Eshafsl5FRPqrYy7FC7eCEAkVkErJZHOPQXq97Ksiws4mF4ybV1WjxcU9vx1KwUd9STgqdGkAeJ7bOrDNbU08MYfZttmyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711100186; c=relaxed/simple;
	bh=Un5FAxnjdEo99yKEgJewvVt9ACNBktRqYLuELAqgtSM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MDQL5J8qtin6fQzThqm2RrJiE6OOKdcNI237C/bIIM2HQP4aXpj9j4JUGx4/2kl+ykZUjhwqnt4XRDNgE65/HLf4/06t8B5gVDBzQ8iGXPEvtMeV6a/cePuk1i3XkFA8WcOqqdkG2ip9Vg2Od3L2zQPWLOl8FZR24C7GMQCyR5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4V1HGS0pCyzNm8T;
	Fri, 22 Mar 2024 17:34:24 +0800 (CST)
Received: from dggpemd200004.china.huawei.com (unknown [7.185.36.141])
	by mail.maildlp.com (Postfix) with ESMTPS id 8079A18007D;
	Fri, 22 Mar 2024 17:36:19 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemd200004.china.huawei.com
 (7.185.36.141) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Fri, 22 Mar
 2024 17:36:18 +0800
From: Liu Shixin <liushixin2@huawei.com>
To: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, Andrew
 Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH v2 1/2] mm/readahead: break read-ahead loop if filemap_add_folio return -ENOMEM
Date: Fri, 22 Mar 2024 17:35:54 +0800
Message-ID: <20240322093555.226789-2-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240322093555.226789-1-liushixin2@huawei.com>
References: <20240322093555.226789-1-liushixin2@huawei.com>
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

When filemap_add_folio() return -ENOMEM, break read-ahead loop like what
filemap_alloc_folio() does.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
Signed-off-by: Jinjiang Tu <tujinjiang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 mm/readahead.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 2648ec4f0494..a8513ffbb17f 100644
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


