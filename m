Return-Path: <linux-fsdevel+bounces-64123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6EDBD945D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 14:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8270018A2A70
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 12:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6A93128B1;
	Tue, 14 Oct 2025 12:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aRg1W5LY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22462D2488
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 12:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760443895; cv=none; b=tKW0RAmOvsAig+rl5QW/y6c3/NNl7XVzgANkGHEzU/z34wzMa+pWR/657Dcc1dGuIzGRxH7+bZtfDmdi7W+chxCtzsOKUwVgtjyTgF6XUl0ZwERGM3lcROICS0X3FjziJHloPTOQnvW1wLMtN5vbyamGWyr16lcJSsEAjKf3dys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760443895; c=relaxed/simple;
	bh=W2CHCvnft7+3e7U/qJ1zuJN0UqWxILVX7B5nHRsKfxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=UZ4iWy1+cl3pesBI/3dOi4lw8kr0SDyMvImvKus5pPuZDl1C36yY1EFf4ShQ3iGNdW06pRmLUwptZnoOmb25MbiJndGR6WFeZhWWEMQeF6agg6DeEBIN2VWLTT0nKjLQlfG79/N2YKVHcZDprLLocoKjEk6/jXseVsXBkGAtO6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=aRg1W5LY; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20251014121128epoutp034371d209e8c5fe7733a802c72ffdf400~uWmPGuFdt0782507825epoutp03E
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 12:11:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20251014121128epoutp034371d209e8c5fe7733a802c72ffdf400~uWmPGuFdt0782507825epoutp03E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1760443888;
	bh=9xfpeIa6BTBN9y5Yua6WUo/kfaK/tK7nGJtau+f6sKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aRg1W5LYNkmKJwBmfMDXQwULILoQQMbKD5xpULndN+acw7wKF+EajcSX901J8Jl1U
	 0srsAeNWSVZqvnUIK60lYB6FgmXELyMEl31IcvSy8TC5CMQsTbWbmK9OWPXlR6Tp98
	 Lbh1JDG2eukum2O3hPuZuuu8mcFlIJOS0JXaVQCY=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20251014121128epcas5p4967119ea4614d684d93c7583f8d5a134~uWmOYhois3228732287epcas5p4S;
	Tue, 14 Oct 2025 12:11:28 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.90]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4cmCk71PPbz2SSKX; Tue, 14 Oct
	2025 12:11:27 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20251014121126epcas5p2ff20c9139bdd702c77b9de50e4f259c7~uWmM4HphY2935829358epcas5p21;
	Tue, 14 Oct 2025 12:11:26 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251014121122epsmtip167b1288b36b0fc975fc831b21babda9a~uWmJEInWw1256612566epsmtip1C;
	Tue, 14 Oct 2025 12:11:22 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: jaegeuk@kernel.org, chao@kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu, agruenba@redhat.com,
	trondmy@kernel.org, anna@kernel.org, akpm@linux-foundation.org,
	willy@infradead.org, mcgrof@kernel.org, clm@meta.com, david@fromorbit.com,
	amir73il@gmail.com, axboe@kernel.dk, hch@lst.de, ritesh.list@gmail.com,
	djwong@kernel.org, dave@stgolabs.net, wangyufei@vivo.com
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, linux-mm@kvack.org,
	gost.dev@samsung.com, kundan.kumar@samsung.com, anuj20.g@samsung.com,
	vishak.g@samsung.com, joshi.k@samsung.com
Subject: [PATCH v2 14/16] writeback: segregated allocation and free of
 writeback contexts
Date: Tue, 14 Oct 2025 17:38:43 +0530
Message-Id: <20251014120845.2361-15-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251014120845.2361-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251014121126epcas5p2ff20c9139bdd702c77b9de50e4f259c7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251014121126epcas5p2ff20c9139bdd702c77b9de50e4f259c7
References: <20251014120845.2361-1-kundan.kumar@samsung.com>
	<CGME20251014121126epcas5p2ff20c9139bdd702c77b9de50e4f259c7@epcas5p2.samsung.com>

The independent functions of alloc and free will be used while changing
the number of writeback contexts.

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 mm/backing-dev.c | 72 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 23 deletions(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 0a3204a3a3a3..2a8f3b683b2d 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -1038,8 +1038,46 @@ static void cgwb_remove_from_bdi_list(struct bdi_writeback *wb)
 
 #endif	/* CONFIG_CGROUP_WRITEBACK */
 
+static struct bdi_writeback_ctx **wb_ctx_alloc(struct backing_dev_info *bdi,
+					       int num_ctxs)
+{
+	struct bdi_writeback_ctx **wb_ctx;
+
+	wb_ctx = kcalloc(num_ctxs, sizeof(struct bdi_writeback_ctx *),
+			     GFP_KERNEL);
+	if (!wb_ctx)
+		return NULL;
+
+	for (int i = 0; i < num_ctxs; i++) {
+		wb_ctx[i] = (struct bdi_writeback_ctx *)
+			kzalloc(sizeof(struct bdi_writeback_ctx), GFP_KERNEL);
+		if (!wb_ctx[i]) {
+			pr_err("Failed to allocate %d", i);
+			while (--i >= 0)
+				kfree(wb_ctx[i]);
+			kfree(wb_ctx);
+			return NULL;
+		}
+		INIT_LIST_HEAD(&wb_ctx[i]->wb_list);
+		init_waitqueue_head(&wb_ctx[i]->wb_waitq);
+	}
+	return wb_ctx;
+}
+
+static void wb_ctx_free(struct backing_dev_info *bdi)
+{
+	struct bdi_writeback_ctx *bdi_wb_ctx;
+
+	for_each_bdi_wb_ctx(bdi, bdi_wb_ctx) {
+		kfree(bdi_wb_ctx);
+	}
+	kfree(bdi->wb_ctx);
+}
+
 int bdi_init(struct backing_dev_info *bdi)
 {
+	int ret;
+
 	bdi->dev = NULL;
 
 	kref_init(&bdi->refcnt);
@@ -1047,48 +1085,36 @@ int bdi_init(struct backing_dev_info *bdi)
 	bdi->max_ratio = 100 * BDI_RATIO_SCALE;
 	bdi->max_prop_frac = FPROP_FRAC_BASE;
 
+	INIT_LIST_HEAD(&bdi->bdi_list);
+
 	/*
 	 * User can configure nr_wb_ctx using the newly introduced sysfs knob.
 	 * echo N > /sys/class/bdi/<maj>:<min>/nwritebacks
 	 * Filesystem can also increase same during mount.
 	 */
 	bdi->nr_wb_ctx = 1;
-	bdi->wb_ctx = kcalloc(bdi->nr_wb_ctx,
-				  sizeof(struct bdi_writeback_ctx *),
-				  GFP_KERNEL);
-	INIT_LIST_HEAD(&bdi->bdi_list);
-	for (int i = 0; i < bdi->nr_wb_ctx; i++) {
-		bdi->wb_ctx[i] = (struct bdi_writeback_ctx *)
-			 kzalloc(sizeof(struct bdi_writeback_ctx), GFP_KERNEL);
-		if (!bdi->wb_ctx[i]) {
-			pr_err("Failed to allocate %d", i);
-			while (--i >= 0)
-				kfree(bdi->wb_ctx[i]);
-			kfree(bdi->wb_ctx);
-			return -ENOMEM;
-		}
-		INIT_LIST_HEAD(&bdi->wb_ctx[i]->wb_list);
-		init_waitqueue_head(&bdi->wb_ctx[i]->wb_waitq);
-	}
+
+	bdi->wb_ctx = wb_ctx_alloc(bdi, bdi->nr_wb_ctx);
+	if (!bdi->wb_ctx)
+		return -ENOMEM;
+
 	bdi->last_bdp_sleep = jiffies;
 
-	return cgwb_bdi_init(bdi);
+	ret = cgwb_bdi_init(bdi);
+	if (ret)
+		wb_ctx_free(bdi);
+	return ret;
 }
 
 struct backing_dev_info *bdi_alloc(int node_id)
 {
 	struct backing_dev_info *bdi;
-	struct bdi_writeback_ctx *bdi_wb_ctx;
 
 	bdi = kzalloc_node(sizeof(*bdi), GFP_KERNEL, node_id);
 	if (!bdi)
 		return NULL;
 
 	if (bdi_init(bdi)) {
-		for_each_bdi_wb_ctx(bdi, bdi_wb_ctx) {
-			kfree(bdi_wb_ctx);
-		}
-		kfree(bdi->wb_ctx);
 		kfree(bdi);
 		return NULL;
 	}
-- 
2.25.1


