Return-Path: <linux-fsdevel+bounces-14970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E41D18859DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 14:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ECB2282B6C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 13:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA74684FD8;
	Thu, 21 Mar 2024 13:16:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAB983CCE;
	Thu, 21 Mar 2024 13:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711027016; cv=none; b=Sj24iYLER9NBqkBaipwp7Mpa6oSezHqZkllmNTIKt4JVwSOhPdkXl6xX8jopjsnZuRnbWqsB1WqTDtgu9kqL1uAYxDGARCCCntaTt9wVWbrdHW4RPsM9E4MheUSUUzKxDj/cPIFmYQoBkoTNV8oNsTLZfNC/SPWjlbqpFSafazo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711027016; c=relaxed/simple;
	bh=1e5/zesv6FbJxBfA8IWa548K58P7zE6KEyqInepG5HQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NeN+1HkPR6HubeLE75vnSpg+ataGe1NuXPgeDIVWom6U17fexpDP3loun78RnxqKSWoLWvuF7rT6qCxtPYBltNgfIYy3Yd2mp0TNqxmW4v8sX+vPXpTOYQDfW8Dag/PYvkC2s2b9OPhysUPRm7sPmjmonC1z4BVcF0cXvogk0LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4V0mBb6TM4z1h2cS;
	Thu, 21 Mar 2024 21:14:15 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 1E51B1400CB;
	Thu, 21 Mar 2024 21:16:50 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 21:16:49 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Benjamin LaHaise
	<bcrl@kvack.org>, Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>, <linux-kernel@vger.kernel.org>, Matthew Wilcox
	<willy@infradead.org>
CC: <linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>, Kefeng Wang
	<wangkefeng.wang@huawei.com>
Subject: [PATCH v2 1/3] fs: aio: use a folio in aio_setup_ring()
Date: Thu, 21 Mar 2024 21:16:38 +0800
Message-ID: <20240321131640.948634-2-wangkefeng.wang@huawei.com>
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

Use a folio throughout aio_setup_ring() to remove calls to compound_head(),
also use folio_end_read() to simultaneously mark the folio uptodate and
unlock it.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 fs/aio.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 9cdaa2faa536..60da236ad575 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -527,17 +527,19 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
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
+		if (IS_ERR(folio))
 			break;
-		pr_debug("pid(%d) page[%d]->count=%d\n",
-			 current->pid, i, page_count(page));
-		SetPageUptodate(page);
-		unlock_page(page);
 
-		ctx->ring_pages[i] = page;
+		pr_debug("pid(%d) [%d] folio->count=%d\n", current->pid, i,
+			 folio_ref_count(folio));
+		folio_end_read(folio, true);
+
+		ctx->ring_pages[i] = &folio->page;
 	}
 	ctx->nr_pages = i;
 
-- 
2.27.0


