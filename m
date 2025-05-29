Return-Path: <linux-fsdevel+bounces-50053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 068DEAC7D27
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 13:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B57384E64A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 11:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E30D291877;
	Thu, 29 May 2025 11:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YnrJd0et"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1611291875
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 11:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748518415; cv=none; b=rGF36y5zAJS+9iUXOX6DQwwJV9zxH6sXjTyoZORCMzcdeEzPK27PMMIErCChcLkjjoaE2conoAY3mpdf8FlPBm/oslMgfSNee3rme1O6Ow4Z1GOqGj9GHOijJ9xkXuhzN5RALiPzXsXhBjCmbOrAgzvOI9ghIp9TZRrwvBerFK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748518415; c=relaxed/simple;
	bh=oO2FLoDWg7GhwsTJf6QXxe3ypztozqPzBmmirGELpvE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=n8HV7HbP87qOoCUPQt8eObf8+ZfwX/I/y4INTpVP1RSHtIhsmBbvHpldORdz5Wk/Vs5fHBIw31sudDPXRnfsUVrxX12KiLz+0EwtVNjMQoktDhm/FPYb+eWLDznurtJtNnXRPVxoAO9Z+4qNMzYYh6/KG6jybL/77aX5zb5mEJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=YnrJd0et; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250529113332epoutp014c5ce7e576260154a46f19d4c39215c7~D-DtoZjZu2841028410epoutp01U
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 11:33:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250529113332epoutp014c5ce7e576260154a46f19d4c39215c7~D-DtoZjZu2841028410epoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748518412;
	bh=ts9ngdqlLw2AEiZ86ZxN1Hs3ycwqqPPWcX97f26fAOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YnrJd0etJxSguxdAPqGpBHI+1IXq2by0WL4ZxyMtjbP4IWf3nWJgjZghWV4WjPBT2
	 zvZfg+ds/JYe37o+0k/LNE7kYDu6ObRDBV1Hz/OsMMWTIW4U9oTQHfsy0OiBB4LFwU
	 0QSTFVgc1D4FegqpAjhsPF1Lr1Qp+CfLS0gBB78s=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250529113331epcas5p31117eefbd7821d886b55aa7d388289a5~D-Ds5oUNm3109531095epcas5p34;
	Thu, 29 May 2025 11:33:31 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.183]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4b7PQ228rNz6B9m5; Thu, 29 May
	2025 11:33:30 +0000 (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250529113224epcas5p2eea35fd0ebe445d8ad0471a144714b23~D-Ct71Fwq0469904699epcas5p2q;
	Thu, 29 May 2025 11:32:24 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250529113224epsmtrp15931173685a255cae3a7376266154c4b~D-Ct6hjf02108121081epsmtrp1t;
	Thu, 29 May 2025 11:32:24 +0000 (GMT)
X-AuditID: b6c32a29-55afd7000000223e-0f-683845c7d353
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A7.D0.08766.7C548386; Thu, 29 May 2025 20:32:23 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250529113219epsmtip24a8a22fe2424d5c844ec10fe7a251a72~D-CqFFjwh0869408694epsmtip2r;
	Thu, 29 May 2025 11:32:19 +0000 (GMT)
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
Subject: [PATCH 02/13] writeback: add support to initialize and free
 multiple writeback ctxs
Date: Thu, 29 May 2025 16:44:53 +0530
Message-Id: <20250529111504.89912-3-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250529111504.89912-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsWy7bCSvO5xV4sMg5vTLCy2rdvNbjFn/Ro2
	iwvrVjNatO78z2LRNOEvs8Xqu/1sFq8Pf2K0OD31LJPFlkv2Fu8vb2OyWH1zDaPFlmP3GC0u
	P+Gz2D39H6vFzQM7mSxWrj7KZDF7ejOTxZP1s5gttn75ympxaZG7xZ69J1ks7q35z2px4cBp
	VosbE54yWjzbvZHZ4vPSFnaLg6c62C0+zQUacv7vcVaL3z/msDnIeZxaJOGxc9Zddo/NK7Q8
	Lp8t9di0qpPNY9OnSeweJ2b8ZvF4sXkmo8fuBZ+ZPHbfbGDzOHexwuP9vqtsHn1bVjF6TJ1d
	73FmwRF2jxXTLjIFCEVx2aSk5mSWpRbp2yVwZSy7dZexYLZ+xekv0xgbGM+odzFyckgImEjM
	uTqDDcQWEtjNKHH0gxxEXEZi992drBC2sMTKf8/ZIWo+MkqsmRTdxcjBwSagK/GjKbSLkYtD
	ROAms8S5s2fA6pkF/jFK7H6lA2ILC8RINHYfZgGxWQRUJRb9PgQ2h1fAVuLfhj3MEPPlJWZe
	+g4W5xSwk1i05CsjxC5biaU317JA1AtKnJz5hAVivrxE89bZzBMYBWYhSc1CklrAyLSKUTK1
	oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM4MWhp7mDcvuqD3iFGJg7GQ4wSHMxKIrxN9mYZ
	QrwpiZVVqUX58UWlOanFhxilOViUxHnFX/SmCAmkJ5akZqemFqQWwWSZODilGpgk3lzo8dvA
	YsTVsvtRmXMuV0Vhd/ZOUzlbaaVZ1klcHhEpVx+eLC/JMW01Mgr78/z7reP9B64mfDqTtyE8
	+Ljm1LZtqZus02a3C/pt3hWwcK+tU80Hv0rLrC/PE+fcqFzqwCfKssbrkGqvhu+iPPN5Z6Mm
	LRH/vO1GbfSOrR+3nN/Qs8by8jnn79IFN9cu2rKL4ZUOw+z4KfM+aWqnno3xOihVumqLvML7
	hkKfdY8cmY+WvzXVfTBn/YbSkwrHIp/Mr0+6+kXw+PML2l7/N6Yw7X38+HZswPv6mUmr/fQ5
	LIIfXexZzWe9vllgf+2lSH+95pj3Wx603GTQCGcP4+A+dTDS46j+QyGbxbUr/2QpsRRnJBpq
	MRcVJwIAj/csfXsDAAA=
X-CMS-MailID: 20250529113224epcas5p2eea35fd0ebe445d8ad0471a144714b23
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250529113224epcas5p2eea35fd0ebe445d8ad0471a144714b23
References: <20250529111504.89912-1-kundan.kumar@samsung.com>
	<CGME20250529113224epcas5p2eea35fd0ebe445d8ad0471a144714b23@epcas5p2.samsung.com>

Introduce a new macro for_each_bdi_wb_ctx to iterate over multiple
writeback ctxs. Added logic for allocation, init, free, registration
and unregistration of multiple writeback contexts within a bdi.

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 include/linux/backing-dev.h |  4 ++
 mm/backing-dev.c            | 79 +++++++++++++++++++++++++++----------
 2 files changed, 62 insertions(+), 21 deletions(-)

diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 894968e98dd8..fbccb483e59c 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -148,6 +148,10 @@ static inline bool mapping_can_writeback(struct address_space *mapping)
 	return inode_to_bdi(mapping->host)->capabilities & BDI_CAP_WRITEBACK;
 }
 
+#define for_each_bdi_wb_ctx(bdi, wb_ctx) \
+	for (int __i = 0; __i < (bdi)->nr_wb_ctx \
+		&& ((wb_ctx) = (bdi)->wb_ctx_arr[__i]) != NULL; __i++)
+
 static inline struct bdi_writeback_ctx *
 fetch_bdi_writeback_ctx(struct inode *inode)
 {
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 0efa9632011a..adf87b036827 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -836,16 +836,19 @@ struct bdi_writeback *wb_get_create(struct backing_dev_info *bdi,
 static int cgwb_bdi_init(struct backing_dev_info *bdi)
 {
 	int ret;
-	struct bdi_writeback_ctx *bdi_wb_ctx = bdi->wb_ctx_arr[0];
+	struct bdi_writeback_ctx *bdi_wb_ctx;
 
-	INIT_RADIX_TREE(&bdi_wb_ctx->cgwb_tree, GFP_ATOMIC);
-	mutex_init(&bdi->cgwb_release_mutex);
-	init_rwsem(&bdi_wb_ctx->wb_switch_rwsem);
+	for_each_bdi_wb_ctx(bdi, bdi_wb_ctx) {
+		INIT_RADIX_TREE(&bdi_wb_ctx->cgwb_tree, GFP_ATOMIC);
+		mutex_init(&bdi->cgwb_release_mutex);
+		init_rwsem(&bdi_wb_ctx->wb_switch_rwsem);
 
-	ret = wb_init(&bdi_wb_ctx->wb, bdi, GFP_KERNEL);
-	if (!ret) {
-		bdi_wb_ctx->wb.memcg_css = &root_mem_cgroup->css;
-		bdi_wb_ctx->wb.blkcg_css = blkcg_root_css;
+		ret = wb_init(&bdi_wb_ctx->wb, bdi, GFP_KERNEL);
+		if (!ret) {
+			bdi_wb_ctx->wb.memcg_css = &root_mem_cgroup->css;
+			bdi_wb_ctx->wb.blkcg_css = blkcg_root_css;
+		} else
+			return ret;
 	}
 	return ret;
 }
@@ -992,7 +995,16 @@ subsys_initcall(cgwb_init);
 
 static int cgwb_bdi_init(struct backing_dev_info *bdi)
 {
-	return wb_init(&bdi->wb_ctx_arr[0]->wb, bdi, GFP_KERNEL);
+	struct bdi_writeback_ctx *bdi_wb_ctx;
+
+	for_each_bdi_wb_ctx(bdi, bdi_wb_ctx) {
+		int ret;
+
+		ret = wb_init(&bdi_wb_ctx->wb, bdi, GFP_KERNEL);
+		if (ret)
+			return ret;
+	}
+	return 0;
 }
 
 static void cgwb_bdi_unregister(struct backing_dev_info *bdi,
@@ -1026,10 +1038,19 @@ int bdi_init(struct backing_dev_info *bdi)
 				  sizeof(struct bdi_writeback_ctx *),
 				  GFP_KERNEL);
 	INIT_LIST_HEAD(&bdi->bdi_list);
-	bdi->wb_ctx_arr[0] = (struct bdi_writeback_ctx *)
-			kzalloc(sizeof(struct bdi_writeback_ctx), GFP_KERNEL);
-	INIT_LIST_HEAD(&bdi->wb_ctx_arr[0]->wb_list);
-	init_waitqueue_head(&bdi->wb_ctx_arr[0]->wb_waitq);
+	for (int i = 0; i < bdi->nr_wb_ctx; i++) {
+		bdi->wb_ctx_arr[i] = (struct bdi_writeback_ctx *)
+			 kzalloc(sizeof(struct bdi_writeback_ctx), GFP_KERNEL);
+		if (!bdi->wb_ctx_arr[i]) {
+			pr_err("Failed to allocate %d", i);
+			while (--i >= 0)
+				kfree(bdi->wb_ctx_arr[i]);
+			kfree(bdi->wb_ctx_arr);
+			return -ENOMEM;
+		}
+		INIT_LIST_HEAD(&bdi->wb_ctx_arr[i]->wb_list);
+		init_waitqueue_head(&bdi->wb_ctx_arr[i]->wb_waitq);
+	}
 	bdi->last_bdp_sleep = jiffies;
 
 	return cgwb_bdi_init(bdi);
@@ -1038,13 +1059,16 @@ int bdi_init(struct backing_dev_info *bdi)
 struct backing_dev_info *bdi_alloc(int node_id)
 {
 	struct backing_dev_info *bdi;
+	struct bdi_writeback_ctx *bdi_wb_ctx;
 
 	bdi = kzalloc_node(sizeof(*bdi), GFP_KERNEL, node_id);
 	if (!bdi)
 		return NULL;
 
 	if (bdi_init(bdi)) {
-		kfree(bdi->wb_ctx_arr[0]);
+		for_each_bdi_wb_ctx(bdi, bdi_wb_ctx) {
+			kfree(bdi_wb_ctx);
+		}
 		kfree(bdi->wb_ctx_arr);
 		kfree(bdi);
 		return NULL;
@@ -1109,6 +1133,7 @@ int bdi_register_va(struct backing_dev_info *bdi, const char *fmt, va_list args)
 {
 	struct device *dev;
 	struct rb_node *parent, **p;
+	struct bdi_writeback_ctx *bdi_wb_ctx;
 
 	if (bdi->dev)	/* The driver needs to use separate queues per device */
 		return 0;
@@ -1118,8 +1143,11 @@ int bdi_register_va(struct backing_dev_info *bdi, const char *fmt, va_list args)
 	if (IS_ERR(dev))
 		return PTR_ERR(dev);
 
-	cgwb_bdi_register(bdi, bdi->wb_ctx_arr[0]);
-	set_bit(WB_registered, &bdi->wb_ctx_arr[0]->wb.state);
+	for_each_bdi_wb_ctx(bdi, bdi_wb_ctx) {
+		cgwb_bdi_register(bdi, bdi_wb_ctx);
+		set_bit(WB_registered, &bdi_wb_ctx->wb.state);
+	}
+
 	bdi->dev = dev;
 
 	bdi_debug_register(bdi, dev_name(dev));
@@ -1174,12 +1202,17 @@ static void bdi_remove_from_list(struct backing_dev_info *bdi)
 
 void bdi_unregister(struct backing_dev_info *bdi)
 {
+	struct bdi_writeback_ctx *bdi_wb_ctx;
+
 	timer_delete_sync(&bdi->laptop_mode_wb_timer);
 
 	/* make sure nobody finds us on the bdi_list anymore */
 	bdi_remove_from_list(bdi);
-	wb_shutdown(&bdi->wb_ctx_arr[0]->wb);
-	cgwb_bdi_unregister(bdi, bdi->wb_ctx_arr[0]);
+
+	for_each_bdi_wb_ctx(bdi, bdi_wb_ctx) {
+		wb_shutdown(&bdi_wb_ctx->wb);
+		cgwb_bdi_unregister(bdi, bdi_wb_ctx);
+	}
 
 	/*
 	 * If this BDI's min ratio has been set, use bdi_set_min_ratio() to
@@ -1205,11 +1238,15 @@ static void release_bdi(struct kref *ref)
 {
 	struct backing_dev_info *bdi =
 			container_of(ref, struct backing_dev_info, refcnt);
+	struct bdi_writeback_ctx *bdi_wb_ctx;
 
 	WARN_ON_ONCE(bdi->dev);
-	WARN_ON_ONCE(test_bit(WB_registered, &bdi->wb_ctx_arr[0]->wb.state));
-	wb_exit(&bdi->wb_ctx_arr[0]->wb);
-	kfree(bdi->wb_ctx_arr[0]);
+
+	for_each_bdi_wb_ctx(bdi, bdi_wb_ctx) {
+		WARN_ON_ONCE(test_bit(WB_registered, &bdi_wb_ctx->wb.state));
+		wb_exit(&bdi_wb_ctx->wb);
+		kfree(bdi_wb_ctx);
+	}
 	kfree(bdi->wb_ctx_arr);
 	kfree(bdi);
 }
-- 
2.25.1


