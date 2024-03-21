Return-Path: <linux-fsdevel+bounces-14969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C60C58859DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 14:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F28F11C21A65
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 13:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E67184FAD;
	Thu, 21 Mar 2024 13:16:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26BF84A35;
	Thu, 21 Mar 2024 13:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711027015; cv=none; b=Dq46x20xXC2k5MvTXRhs8UUKVP9jdSEgE8o8+3UmoMslgvv09PVA4dmyzDhbp/ZkSM+ckPgfB5shNpyGHLGIzQTLbkG2EoHpd4xeYpegXkc19wK3T7/OdOv1ozLDbnN2uOz+xnYqbxq8BRFCoEbChzZjlY0svwnABYe05pDZH4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711027015; c=relaxed/simple;
	bh=SHnQtw4dKc0R/ujzvDsJeNwStpWmku6bHV78paAk1vM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tYWO1FdkqDmYwbt+eDyt7hL5QYJ/+sS1IU/scHrBov44F7UNarGTJhGMVTHipB8adHs4Rsa7skpUlvKwsXlxu9IGRzcGgvxxZ900vul2cdSOCzKzaE0Gd6kK4S5TI+CNMcYX7qrXScXVp3WjOpZfYRbBFouBNHiLah2yIvBE+7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4V0mF614tJz1GCJd;
	Thu, 21 Mar 2024 21:16:26 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 9E1E51A016C;
	Thu, 21 Mar 2024 21:16:50 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 21:16:50 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Benjamin LaHaise
	<bcrl@kvack.org>, Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>, <linux-kernel@vger.kernel.org>, Matthew Wilcox
	<willy@infradead.org>
CC: <linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>, Kefeng Wang
	<wangkefeng.wang@huawei.com>
Subject: [PATCH v2 2/3] fs: aio: use a folio in aio_free_ring()
Date: Thu, 21 Mar 2024 21:16:39 +0800
Message-ID: <20240321131640.948634-3-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240321131640.948634-1-wangkefeng.wang@huawei.com>
References: <20240321131640.948634-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100001.china.huawei.com (7.185.36.93)

Use a folio throughout aio_free_ring() to remove calls to compound_head(),
also move pr_debug after folio check to remove unnecessary print.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 fs/aio.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 60da236ad575..738654b58bfb 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -334,14 +334,15 @@ static void aio_free_ring(struct kioctx *ctx)
 	put_aio_ring_file(ctx);
 
 	for (i = 0; i < ctx->nr_pages; i++) {
-		struct page *page;
-		pr_debug("pid(%d) [%d] page->count=%d\n", current->pid, i,
-				page_count(ctx->ring_pages[i]));
-		page = ctx->ring_pages[i];
-		if (!page)
+		struct folio *folio = page_folio(ctx->ring_pages[i]);
+
+		if (!folio)
 			continue;
+
+		pr_debug("pid(%d) [%d] folio->count=%d\n", current->pid, i,
+			 folio_ref_count(folio));
 		ctx->ring_pages[i] = NULL;
-		put_page(page);
+		folio_put(folio);
 	}
 
 	if (ctx->ring_pages && ctx->ring_pages != ctx->internal_pages) {
-- 
2.27.0


