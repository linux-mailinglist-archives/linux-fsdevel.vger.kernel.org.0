Return-Path: <linux-fsdevel+bounces-14956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AB68855A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 09:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 842FE1F23F84
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 08:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2754669970;
	Thu, 21 Mar 2024 08:27:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547EE56450;
	Thu, 21 Mar 2024 08:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711009664; cv=none; b=AAIouMJmxzUYWOT4WdTAaccNx6iMr6qKiau0aNcEAmiTCJ+ukrarPPtOINJN+5qORwoNnklNXhJ8tsWqoN9vS+p84VDelk0XEd7S2xB77r9R4N3hoFiNUeElRki727LTzoaRCHUTHkpieSeqvvBDEVw42wMeavywq4ykeoUkfTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711009664; c=relaxed/simple;
	bh=qx5vHNazRjcBBazlPi/1CY3SCPXV75gaKD4xNYfO9BU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Of59hMW4c1zGLWMWVsXPcK7qFACp+hu1ciO4715DvJK8yO+qD1fxL1veiPpdKqzhDD0wXW0QlticUBt2YkQX/K6klzbDoV0w+eiJrGjE/aKOJOvySYA3WEQlZyqDJA5vaslUbvhjqynVYz3EJwZzBUt17WvdocDH/ZT26rq+kPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4V0dmr5dzhzXjDb;
	Thu, 21 Mar 2024 16:25:00 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id B4E0A140FEF;
	Thu, 21 Mar 2024 16:27:38 +0800 (CST)
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
Subject: [PATCH 1/3] fs: aio: use a folio in aio_setup_ring()
Date: Thu, 21 Mar 2024 16:27:31 +0800
Message-ID: <20240321082733.614329-2-wangkefeng.wang@huawei.com>
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

Use a folio throughout aio_setup_ring() to remove calls to compound_head().

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 fs/aio.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 9cdaa2faa536..d7f6c8705016 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -527,17 +527,20 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
 	}
 
 	for (i = 0; i < nr_pages; i++) {
-		struct page *page;
-		page = find_or_create_page(file->f_mapping,
-					   i, GFP_USER | __GFP_ZERO);
-		if (!page)
+		struct folio *folio;
+
+		folio = __filemap_get_folio(file->f_mapping, i,
+					    FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
+					    GFP_USER | __GFP_ZERO);
+		if (!folio)
 			break;
-		pr_debug("pid(%d) page[%d]->count=%d\n",
-			 current->pid, i, page_count(page));
-		SetPageUptodate(page);
-		unlock_page(page);
 
-		ctx->ring_pages[i] = page;
+		pr_debug("pid(%d) [%d] folio->count=%d\n", current->pid, i,
+			 folio_ref_count(folio));
+		folio_mark_uptodate(folio);
+		folio_unlock(folio);
+
+		ctx->ring_pages[i] = &folio->page;
 	}
 	ctx->nr_pages = i;
 
-- 
2.27.0


