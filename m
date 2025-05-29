Return-Path: <linux-fsdevel+bounces-50054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CB7AC7D2B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 13:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36B069E27E5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 11:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3CE29187A;
	Thu, 29 May 2025 11:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="M0Dd8EwA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E62291879
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 11:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748518418; cv=none; b=k5xCxzSVv73DGZSXZyPdyK6KONpvSrmvtcxpdnA0h524GAQtExP2fzBF1kY9W3JCAynrS/y3iC90XcJS0WNwPiWhxDoDxgibP0VZkfg3EvEzF0lGw2aLEGcspjK4GS2/RNsXsRdCnXuB6dyax9xQWJ66KAzHJWgwvBLhMXwpa08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748518418; c=relaxed/simple;
	bh=vNuBDJrOdHd+FFpdj4SIXSOrt9OmMninxBd/XfxqD7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=dfTc61ZAh4JXk5Pjzx2r66U17XWUdT+YgYe8oRnkZ6mgptoiU3diiotJVIpSbZCGJV09f4bgfP+4DRLP4c26ZjxInGNFvAYW23/2CQVF82bxj0+TlMklOiEPDDN8CU3RauhOOC9/gsSZHoLG+xUNdrgoDzd/J0mi5Q71wE35j38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=M0Dd8EwA; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250529113334epoutp049094e590bc55dbb04fc6a98b2132b41b~D-DvvScak2606426064epoutp04F
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 11:33:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250529113334epoutp049094e590bc55dbb04fc6a98b2132b41b~D-DvvScak2606426064epoutp04F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748518414;
	bh=C+GkTvY8D+25yzgyaUuIRcKdgNOM65N4VuaT+9A3U20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M0Dd8EwAQCPVy6eDoA4GBnmyRNl3UzEn0tKLYWgdBq/xpXX68gwjrxvB/EjRHqiUi
	 GDD1ITPIzQ3IJSbQivWQXzvMbbT3iLF5JUIJ9xUSR0uZgxLmfj1pAiWDg5TlJE78y6
	 2YT2jn40umUcI2PnySYqvInYEYiJcH1j+dNk7/hs=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250529113333epcas5p25fabe3ac0cd0719ee03e87bb5e07bf7a~D-DvEukTO0067100671epcas5p23;
	Thu, 29 May 2025 11:33:33 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.183]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4b7PQ44jtzz6B9mB; Thu, 29 May
	2025 11:33:32 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250529113228epcas5p1db88ab42c2dac0698d715e38bd5e0896~D-Cx47Ddm1656216562epcas5p14;
	Thu, 29 May 2025 11:32:28 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250529113228epsmtrp2808b8d9371493c789a9bbd52ec76c111~D-Cx3omtG3187631876epsmtrp2K;
	Thu, 29 May 2025 11:32:28 +0000 (GMT)
X-AuditID: b6c32a29-55afd7000000223e-21-683845cc5b4a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5B.D0.08766.CC548386; Thu, 29 May 2025 20:32:28 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250529113224epsmtip2211a0716625a96f0108b68b63ae02743~D-CuAx6332456924569epsmtip2I;
	Thu, 29 May 2025 11:32:23 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: jaegeuk@kernel.org, chao@kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu, agruenba@redhat.com,
	trondmy@kernel.org, anna@kernel.org, akpm@linux-foundation.org,
	willy@infradead.org, mcgrof@kernel.org, clm@meta.com, david@fromorbit.com,
	amir73il@gmail.com, axboe@kernel.dk, hch@lst.de, ritesh.list@gmail.com,
	djwong@kernel.org, dave@stgolabs.net, p.raghav@samsung.com,
	da.gomez@samsung.com
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, linux-mm@kvack.org,
	gost.dev@samsung.com, Kundan Kumar <kundan.kumar@samsung.com>, Anuj Gupta
	<anuj20.g@samsung.com>
Subject: [PATCH 03/13] writeback: link bdi_writeback to its corresponding
 bdi_writeback_ctx
Date: Thu, 29 May 2025 16:44:54 +0530
Message-Id: <20250529111504.89912-4-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250529111504.89912-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsWy7bCSvO4ZV4sMg+09XBbb1u1mt5izfg2b
	xYV1qxktWnf+Z7FomvCX2WL13X42i9eHPzFanJ56lsliyyV7i/eXtzFZrL65htFiy7F7jBaX
	n/BZ7J7+j9Xi5oGdTBYrVx9lspg9vZnJ4sn6WcwWW798ZbW4tMjdYs/ekywW99b8Z7W4cOA0
	q8WNCU8ZLZ7t3shs8XlpC7vFwVMd7Baf5gINOf/3OKvF7x9z2BzkPE4tkvDYOesuu8fmFVoe
	l8+Wemxa1cnmsenTJHaPEzN+s3i82DyT0WP3gs9MHrtvNrB5nLtY4fF+31U2j74tqxg9ps6u
	9ziz4Ai7x4ppF5kChKK4bFJSczLLUov07RK4MrZtNyu4xF9xYotVA+NTni5GTg4JAROJKU9n
	sHUxcnEICexmlFhydzILREJGYvfdnawQtrDEyn/P2SGKPjJKbJvYApTg4GAT0JX40RQKEhcR
	uMksce7sGbAGZoF/jBK7X+mA1AgLREvs2FkDEmYRUJXY3HGPEcTmFbCV+La5nx1ivrzEzEvf
	wWxOATuJRUu+gtUIAdUsvbmWBaJeUOLkzCcsEOPlJZq3zmaewCgwC0lqFpLUAkamVYySqQXF
	uem5xYYFhnmp5XrFibnFpXnpesn5uZsYwWlBS3MH4/ZVH/QOMTJxMB5ilOBgVhLhbbI3yxDi
	TUmsrEotyo8vKs1JLT7EKM3BoiTOK/6iN0VIID2xJDU7NbUgtQgmy8TBKdXAxDF/zyENzwxX
	U1nz9ifb/Y/80FU4U7SrJ6x9+YcHbv/rnVtmfVBbWCF08HNluNwLrnWy3bcvZPOfcuTN6grl
	WeP4trE+LuFHya/tvW+9bPLX5S825D0gaDRT1/1BbRyDZk7V9hnWclaZWbw8B94mif5If1lR
	9fTQOebk3I/WhZ3tCb/2SnQfT0hg3xV3+FjN1rZvXQcbH92Skd84T36n8Z18f2bdK39dVinF
	82mnlWrrbNfZ+fOc+cR5B/vWVUfcv9KktYDrv8SH/YZX4lYU+N81ypi37OmToJXxSnt+JspP
	OKUnrNtUw/Y2aoqG+8UHqn6bldfOT52Won7O3Thn+7fOVa8fFb6P33B2cdYzJZbijERDLeai
	4kQAd51hDnoDAAA=
X-CMS-MailID: 20250529113228epcas5p1db88ab42c2dac0698d715e38bd5e0896
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250529113228epcas5p1db88ab42c2dac0698d715e38bd5e0896
References: <20250529111504.89912-1-kundan.kumar@samsung.com>
	<CGME20250529113228epcas5p1db88ab42c2dac0698d715e38bd5e0896@epcas5p1.samsung.com>

Introduce a bdi_writeback_ctx field in bdi_writeback. This helps in
fetching the writeback context from the bdi_writeback.

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 mm/backing-dev.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index adf87b036827..5479e2d34160 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -513,15 +513,16 @@ static void wb_update_bandwidth_workfn(struct work_struct *work)
  */
 #define INIT_BW		(100 << (20 - PAGE_SHIFT))
 
-static int wb_init(struct bdi_writeback *wb, struct backing_dev_info *bdi,
-		   gfp_t gfp)
+static int wb_init(struct bdi_writeback *wb,
+		   struct bdi_writeback_ctx *bdi_wb_ctx,
+		   struct backing_dev_info *bdi, gfp_t gfp)
 {
 	int err;
 
 	memset(wb, 0, sizeof(*wb));
 
 	wb->bdi = bdi;
-	wb->bdi_wb_ctx = bdi->wb_ctx_arr[0];
+	wb->bdi_wb_ctx = bdi_wb_ctx;
 	wb->last_old_flush = jiffies;
 	INIT_LIST_HEAD(&wb->b_dirty);
 	INIT_LIST_HEAD(&wb->b_io);
@@ -698,7 +699,7 @@ static int cgwb_create(struct backing_dev_info *bdi,
 		goto out_put;
 	}
 
-	ret = wb_init(wb, bdi, gfp);
+	ret = wb_init(wb, bdi_wb_ctx, bdi, gfp);
 	if (ret)
 		goto err_free;
 
@@ -843,7 +844,7 @@ static int cgwb_bdi_init(struct backing_dev_info *bdi)
 		mutex_init(&bdi->cgwb_release_mutex);
 		init_rwsem(&bdi_wb_ctx->wb_switch_rwsem);
 
-		ret = wb_init(&bdi_wb_ctx->wb, bdi, GFP_KERNEL);
+		ret = wb_init(&bdi_wb_ctx->wb, bdi_wb_ctx, bdi, GFP_KERNEL);
 		if (!ret) {
 			bdi_wb_ctx->wb.memcg_css = &root_mem_cgroup->css;
 			bdi_wb_ctx->wb.blkcg_css = blkcg_root_css;
@@ -1000,7 +1001,7 @@ static int cgwb_bdi_init(struct backing_dev_info *bdi)
 	for_each_bdi_wb_ctx(bdi, bdi_wb_ctx) {
 		int ret;
 
-		ret = wb_init(&bdi_wb_ctx->wb, bdi, GFP_KERNEL);
+		ret = wb_init(&bdi_wb_ctx->wb, bdi_wb_ctx, bdi, GFP_KERNEL);
 		if (ret)
 			return ret;
 	}
-- 
2.25.1


