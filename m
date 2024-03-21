Return-Path: <linux-fsdevel+bounces-14957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC978855EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 09:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 523CA1F21DDB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 08:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E24F1D6AA;
	Thu, 21 Mar 2024 08:44:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D52E12B81;
	Thu, 21 Mar 2024 08:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711010688; cv=none; b=UKk3cL7GvYSP62kUY4MVuXHBSnk+uU36/UWwRkoUXbtKtRxK7PSQGFg9D2hyBvG8JOfcjC3lgwobEPhrGkZ+sh3tWInQZ773JnLU3mqIwqw/ZH7wJ+eILtuG/gqtS69PNYDzbh6w6mSE1sIVNwy1aFWsGl9m/kHaGpOHte75Eiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711010688; c=relaxed/simple;
	bh=X38p6OqcbJmyjiky0IhYh0PoLb64QszYO0PMJVelMzg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G/iDZM2CflGJAtnazjPHiQN8eseWr1ybpEFo9BNbc3V5PczuXnzc1vJFf2ELtDMjKH3h0sNsQqiWwpLuy7mulU1bYW7TrSk+jqsMa1sYRh5UYwbd6oiM9p2/6JcopNe/fh+7GcDUjiod2jYYIg/QI/oUL0rqua16+TedKmIKFuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4V0dmx47bszwPv5;
	Thu, 21 Mar 2024 16:25:05 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 3B4921400DC;
	Thu, 21 Mar 2024 16:27:39 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 16:27:38 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Benjamin LaHaise
	<bcrl@kvack.org>, Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>, <linux-kernel@vger.kernel.org>, Matthew Wilcox
	<willy@infradead.org>
CC: <linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>, Kefeng Wang
	<wangkefeng.wang@huawei.com>
Subject: [PATCH 2/3] fs: aio: use a folio in aio_free_ring()
Date: Thu, 21 Mar 2024 16:27:32 +0800
Message-ID: <20240321082733.614329-3-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240321082733.614329-1-wangkefeng.wang@huawei.com>
References: <20240321082733.614329-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm100001.china.huawei.com (7.185.36.93)

Use a folio throughout aio_free_ring() to remove calls to compound_head().

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 fs/aio.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index d7f6c8705016..2c155be67b9a 100644
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


